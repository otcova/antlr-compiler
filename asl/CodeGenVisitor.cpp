//////////////////////////////////////////////////////////////////////
//
//    CodeGenVisitor - Walk the parser tree to do
//                     the generation of code
//
//    Copyright (C) 2020-2030  Universitat Politecnica de Catalunya
//
//    This library is free software; you can redistribute it and/or
//    modify it under the terms of the GNU General Public License
//    as published by the Free Software Foundation; either version 3
//    of the License, or (at your option) any later version.
//
//    This library is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//    Affero General Public License for more details.
//
//    You should have received a copy of the GNU Affero General Public
//    License along with this library; if not, write to the Free Software
//    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
//
//    contact: José Miguel Rivero (rivero@cs.upc.edu)
//             Computer Science Department
//             Universitat Politecnica de Catalunya
//             despatx Omega.110 - Campus Nord UPC
//             08034 Barcelona.  SPAIN
//
//////////////////////////////////////////////////////////////////////

#include "CodeGenVisitor.h"
#include "TypeCheckVisitor.h"
#include "antlr4-runtime.h"

#include "../common/SymTable.h"
#include "../common/TreeDecoration.h"
#include "../common/TypesMgr.h"
#include "../common/code.h"

#include <any>
#include <cassert>
#include <cstddef> // std::size_t
#include <string>
#include <vector>

// uncomment the following line to enable debugging messages with DEBUG*
// #define DEBUG_BUILD
#include "../common/debug.h"
#define LOG(x) std::cerr << " ---- " << x << std::endl;

// using namespace std;

// Constructor
CodeGenVisitor::CodeGenVisitor(TypesMgr &Types, SymTable &Symbols,
                               TreeDecoration &Decorations)
    : Types{Types}, Symbols{Symbols}, Decorations{Decorations} {}

// Accessor/Mutator to the attribute currFunctionType
TypesMgr::TypeId CodeGenVisitor::getCurrentFunctionTy() const {
    return currFunctionType;
}

void CodeGenVisitor::setCurrentFunctionTy(TypesMgr::TypeId type) {
    currFunctionType = type;
}

std::string CodeGenVisitor::newTemp() {
    return "%" + codeCounters.newTEMP();
}

instructionList CodeGenVisitor::inst(Assign assign) {
    instructionList code;

    std::string src = assign.src;
    std::string dst = assign.dst;

    std::string dstOffset = assign.dstOffset;
    if (dstOffset != "")
    {
        dstOffset = newTemp();
        code = code || instruction::LOAD(dstOffset, assign.dstOffset);
    }

    if (assign.srcOffset != "") {
        CodeAttribs&& srcElement = inst_load(assign.src, assign.srcOffset);
        code = code || srcElement.code;
        src = srcElement.addr;
    }

    // Handle array by reference
    if (dstOffset != "") {
        if (Symbols.isParameterClass(dst)) {
            std::string arrayAddr = newTemp();
            code = code || instruction::LOAD(arrayAddr, dst);
            dst = arrayAddr;
        }
    }

    // Float -> Int conversion
    if (Types.isIntegerTy(assign.srcType) && Types.isFloatTy(assign.dstType))
    {
        std::string temp = newTemp();
        code = code || instruction::FLOAT(temp, src);
        src = temp;
    }

    if (dstOffset != "") // a[i] = x
        code = code || instruction::XLOAD(dst, dstOffset, src);
    else  // x = y // x = a[i]
        code = code || instruction::LOAD(dst, src);

    return code;
}

instructionList CodeGenVisitor::inst(ForRange inst_for) {
    instructionList code;

    // For loop condition: i < end
    std::string condVar = newTemp();

    // define start & end
    std::string increment = newTemp();
    code = code || instruction::ILOAD(increment, inst_for.increment);
    std::string end = newTemp();
    code = code || instruction::ILOAD(end, inst_for.end);

    // i = start;
    code = code || instruction::ILOAD(inst_for.index, inst_for.start);

    // i < end
    instructionList condCode = instruction::LT(condVar, inst_for.index, end);
    CodeAttribs cond(condVar, "", condCode);

    // while (i < end) { inst_for.body; ++i }
    code = code || inst(While {
        .cond = cond,
        .body = inst_for.body || instruction::ADD(inst_for.index, inst_for.index, increment)
    });

    return code;
}

instructionList CodeGenVisitor::inst(While inst_while) {
    std::string label = codeCounters.newLabelWHILE();

    std::string labelEndWhile = "endwhile" + label;
    std::string labelStartWhile = "while" + label;

    // while:
    //      code...
    //      if !cond jump endwhile 
    //      jump while
    // endwhile:
    return instruction::LABEL(labelStartWhile) || inst_while.cond.code ||
           instruction::FJUMP(inst_while.cond.addr, labelEndWhile) || inst_while.body ||
           instruction::UJUMP(labelStartWhile) ||
           instruction::LABEL(labelEndWhile);
}

instructionList CodeGenVisitor::inst(If inst_if) {
    std::string label_id = codeCounters.newLabelIF();
    std::string exitLabel = "exit_if_" + label_id;
    std::string falseLabel = "else_if_" + label_id;

    //  ifFalse condition => jump false_label
    //      true_body
    //      jump exit_label
    //  false_label:
    //      else_body
    //  exit_label:
    return instruction::FJUMP(inst_if.condition, falseLabel)
        || inst_if.trueBody || instruction::UJUMP(exitLabel) ||
        instruction::LABEL(falseLabel) || inst_if.falseBody ||
        instruction::LABEL(exitLabel);
}

instructionList CodeGenVisitor::inst(FuncCall inst_call) {
    instructionList code;

    code = code || instruction::PUSH(); // for saving the result

    for (size_t i = 0; i < inst_call.arguments.size(); ++i) {
        const CodeAttribs &param = inst_call.arguments[i];
        TypesMgr::TypeId paramType = inst_call.argumentsTypes[i];

        std::string value = newTemp();
        
        code = code || param.code;

        if (Types.isArrayTy(paramType)) {
            if (Symbols.isParameterClass(param.addr)) {
                value = param.addr;
            } else {
                code = code || instruction::ALOAD(value, param.addr);
            }
        } else {
            code = code || inst(Assign {
                .dstType = Types.getParameterType(inst_call.functionType, i),
                .dst = value,

                .srcType = paramType,
                .src = param.addr,
                .srcOffset = param.offs,
            });
        }
        code = code || instruction::PUSH(value);
    }

    code = code || instruction::CALL(inst_call.functionName);

    for (size_t i = 0; i < inst_call.arguments.size(); ++i) {
        code = code || instruction::POP();
    }

    code = code || instruction::POP(inst_call.result);

    return code;
}

CodeGenVisitor::CodeAttribs CodeGenVisitor::inst_load(const std::string& addr, const std::string& offset) {
    CodeAttribs codAts(addr, "", {});

    // Handle array by reference
    if (Symbols.isParameterClass(addr) && Types.isArrayTy(Symbols.getType(addr))) {
        std::string arrayAddr = newTemp();
        // temp = addr
        codAts.code = codAts.code || instruction::LOAD(arrayAddr, addr);
        codAts.addr = arrayAddr;
    }

    if (offset == "") {
        return codAts;
    } else {
        // Handle array with offset
        std::string temp = newTemp();
        std::string offsetTemp = newTemp();
        codAts.code = codAts.code || instruction::LOAD(offsetTemp, offset);
        // temp = code.addr[offsetTemp]
        codAts.code = codAts.code || instruction::LOADX(temp, codAts.addr, offsetTemp);
        codAts.addr = temp;
        return codAts;
    }
}

// Methods to visit each kind of node:
//
std::any CodeGenVisitor::visitProgram(AslParser::ProgramContext *ctx) {
    DEBUG_ENTER();
    code my_code;
    SymTable::ScopeId sc = getScopeDecor(ctx);
    Symbols.pushThisScope(sc);
    for (auto ctxFunc : ctx->function()) {
        subroutine subr = std::any_cast<subroutine>(visit(ctxFunc));
        my_code.add_subroutine(subr);
    }
    Symbols.popScope();
    DEBUG_EXIT();
    return my_code;
}

std::any CodeGenVisitor::visitFunction(AslParser::FunctionContext *ctx) {
    DEBUG_ENTER();
    SymTable::ScopeId sc = getScopeDecor(ctx);
    Symbols.pushThisScope(sc);
    subroutine subr(ctx->ID()->getText());
    codeCounters.reset();

    TypesMgr::TypeId returnType = Types.createVoidTy();

    // Define Return Variable
    if (ctx->basic_type()) {
        returnType = getTypeDecor(ctx->basic_type());
        subr.add_param("_result", Types.to_string(returnType));
    }

    std::vector<TypesMgr::TypeId> paramsTypes;

    // Define Parameters
    for (auto *param : ctx->parameters()->parameter()) {
        std::string name = param->ID()->getText();
        TypesMgr::TypeId type = getTypeDecor(param->type());
        paramsTypes.push_back(type);

        if (Types.isArrayTy(type)) {
            TypesMgr::TypeId elementType = Types.getArrayElemType(type);
            subr.add_param(name, Types.to_string(elementType), true);
        } else {
            subr.add_param(name, Types.to_string(type));
        }
    }

    setCurrentFunctionTy(Types.createFunctionTy(paramsTypes, returnType));


    // Define Local Variables
    std::vector<var> &&lvars =
        std::any_cast<std::vector<var>>(visit(ctx->declarations()));
    for (auto &onevar : lvars) {
        subr.add_var(onevar);
    }

    // Define Code
    instructionList &&code =
        std::any_cast<instructionList>(visit(ctx->statements()));
    
    // In case of void function
    code = code || instruction(instruction::RETURN());


    subr.set_instructions(code);
    Symbols.popScope();
    DEBUG_EXIT();
    return subr;
}

std::any CodeGenVisitor::visitDeclarations(AslParser::DeclarationsContext *ctx) {
    DEBUG_ENTER();
    std::vector<var> lvars;
    for (auto &varDeclCtx : ctx->variable_decl()) {
        std::vector<var> morevar =
            std::any_cast<std::vector<var>>(visit(varDeclCtx));
        lvars.insert(lvars.end(), morevar.begin(), morevar.end());
    }
    DEBUG_EXIT();
    return lvars;
}

std::any
CodeGenVisitor::visitVariable_decl(AslParser::Variable_declContext *ctx) {
    DEBUG_ENTER();
    TypesMgr::TypeId t1 = getTypeDecor(ctx->type());
    
    std::size_t size = Types.getSizeOfType(t1);
    DEBUG_EXIT();

    if (Types.isArrayTy(t1))
        t1 = Types.getArrayElemType(t1);
    
    std::vector<var> ids;
    for (size_t i = 0; i < ctx->ID().size(); i++)
        ids.push_back(var{ctx->ID(i)->getText(), Types.to_string(t1), size});

    return ids;
}

// std::any CodeGenVisitor::visitTypeBasicType(AslParser::TypeBasicTypeContext *ctx)
// {
//     DEBUG_ENTER();
//     var basicType = std::any_cast<var>(visit(ctx->basic_type()));

//     DEBUG_EXIT();
//     return basicType;
// }


// std::any CodeGenVisitor::visitTypeArray(AslParser::TypeArrayContext *ctx)
// {
//     DEBUG_ENTER();
//     var basicType = std::any_cast<var>(visit(ctx->basic_type()));
//     std::string array = ctx->ARRAY()->getText();
//     size_t size = std::stoi(ctx->INTVAL()->getText());

//     DEBUG_EXIT();
//     return var(array, basicType.type, size);
// }

std::any CodeGenVisitor::visitStatements(AslParser::StatementsContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    for (auto stCtx : ctx->statement()) {
        code = code || instruction::CHLOAD(";;;", stCtx->getText());

        instructionList &&codeS = std::any_cast<instructionList>(visit(stCtx));
        code = code || codeS;
    }
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitAssignStmt(AslParser::AssignStmtContext *ctx) {
    DEBUG_ENTER();
    instructionList code;

    CodeAttribs &&codeAtsLhs =
        std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string addrLhs = codeAtsLhs.addr;
    std::string offsLhs = codeAtsLhs.offs;
    instructionList &codeLhs = codeAtsLhs.code;

    TypesMgr::TypeId typeLhs = getTypeDecor(ctx->left_expr());

    CodeAttribs &&codeAtsRhs = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string addrRhs = codeAtsRhs.addr;
    instructionList &codeRhs = codeAtsRhs.code;
    std::string offsRhs = codeAtsRhs.offs;

    TypesMgr::TypeId typeRhs = getTypeDecor(ctx->expr());

    code = code || codeLhs || codeRhs;

    if (Types.isArrayTy(typeLhs)) {
        TypesMgr::TypeId elemTypeLhs = Types.getArrayElemType(typeLhs);
        TypesMgr::TypeId elemTypeRhs = Types.getArrayElemType(typeRhs);
        size_t size = Types.getArraySize(typeLhs);

        std::string index = newTemp();

        // value = src[i]
        CodeAttribs value = inst_load(addrRhs, index);
        instructionList body = value.code;

        // dst[i] = value
        body = body || inst(Assign {
            .dstType = elemTypeLhs,
            .dst = addrLhs,
            .dstOffset = index,
            .srcType = elemTypeRhs,
            .src = value.addr,
        });
        
        // for i in 0..size { dst[i] = src[i]; }
        code = code || inst(ForRange {
            .start = "0",
            .end = std::to_string(size),
            .index=index,
            .body = body,
        });
    } else {
        code = code || inst(Assign {
            .dstType = typeLhs,
            .dst = addrLhs,
            .dstOffset = offsLhs,
            .srcType = typeRhs,
            .src = addrRhs
        });
    }

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitIfStmt(AslParser::IfStmtContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&condition = std::any_cast<CodeAttribs>(visit(ctx->expr()));

    instructionList &&trueBody =
        std::any_cast<instructionList>(visit(ctx->statements(0))); 

    instructionList falseBody = {};
    if (ctx->statements(1))
        falseBody = std::any_cast<instructionList>(visit(ctx->statements(1))); 


    instructionList code = condition.code || inst(If {
        .condition = condition.addr,
        .trueBody = trueBody,
        .falseBody = falseBody,
    });
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitWhileStmt(AslParser::WhileStmtContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&cond = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    instructionList &&body = std::any_cast<instructionList>(visit(ctx->statements()));

    instructionList code = inst(While { cond, body});

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitProcCall(AslParser::ProcCallContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    std::string name = ctx->ident()->getText();
    // std::string name = ctx->ident()->ID()->getSymbol()->getText();

    if (!Types.isVoidFunction(getTypeDecor(ctx->ident())))
        code = code || instruction::PUSH(); // for param result

    for (size_t i = 0; i < ctx->expr().size(); ++i) {
        CodeAttribs &&param = std::any_cast<CodeAttribs>(visit(ctx->expr(i)));

        code = code || param.code;
        TypesMgr::TypeId paramType = Types.getParameterType(getTypeDecor(ctx->ident()), i);
        TypesMgr::TypeId valueType = getTypeDecor(ctx->expr(i));

        if (Types.isFloatTy(paramType) && Types.isIntegerTy(valueType))
        {
            std::string temp = newTemp();
            code = code || instruction::FLOAT(temp, param.addr);
            param.addr = temp;
        }

        if (Types.isArrayTy(paramType) && !Symbols.isParameterClass(param.addr))
        {
            std::string temp = newTemp();
            code = code || instruction::ALOAD(temp, param.addr);
            param.addr = temp;
        }

        code = code || instruction::PUSH(param.addr);
    }

    code = code || instruction::CALL(name);

    for (size_t i = 0; i < ctx->expr().size(); ++i) {
        code = code || instruction::POP();
    }

    if (!Types.isVoidFunction(getTypeDecor(ctx->ident())))
        code = code || instruction::POP(); // for param result

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitReadStmt(AslParser::ReadStmtContext *ctx) {
    DEBUG_ENTER();

    CodeAttribs &&codAtsDst = std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string addr1 = codAtsDst.addr;
    std::string offs1 = codAtsDst.offs;
    TypesMgr::TypeId type = getTypeDecor(ctx->left_expr());

    instructionList code = codAtsDst.code;

    std::string input = newTemp();
    if (Types.isIntegerTy(type))
        code = code || instruction::READI(input);
    else if (Types.isFloatTy(type))
        code = code || instruction::READF(input);
    else if (Types.isCharacterTy(type))
        code = code || instruction::READC(input);
    else if (Types.isBooleanTy(type))
        code = code || instruction::READI(input);

    code = code || inst(Assign {
        .dstType=type,
        .dst = addr1,
        .dstOffset = offs1,
        .srcType = type,
        .src = input
    });

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitWriteExpr(AslParser::WriteExprContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAt1 = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string addr1 = codAt1.addr;
    // std::string         offs1 = codAt1.offs;
    instructionList &code1 = codAt1.code;
    instructionList &code = code1;
    TypesMgr::TypeId tid1 = getTypeDecor(ctx->expr());

    if (Types.isIntegerTy(tid1))
        code = code1 || instruction::WRITEI(addr1);
    else if (Types.isFloatTy(tid1))
        code = code1 || instruction::WRITEF(addr1);
    else if (Types.isCharacterTy(tid1))
        code = code1 || instruction::WRITEC(addr1);
    else if (Types.isBooleanTy(tid1))
        code = code1 || instruction::WRITEI(addr1);

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitWriteString(AslParser::WriteStringContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    std::string s = ctx->STRING()->getText();
    code = code || instruction::WRITES(s);
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitReturn(AslParser::ReturnContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    if (ctx->expr()) {
        CodeAttribs &&resultCode = std::any_cast<CodeAttribs>(visit(ctx->expr()));
        code = code || resultCode.code || inst(Assign {
            .dstType = Types.getFuncReturnType(getCurrentFunctionTy()),
            .dst = "_result",
            .srcType = getTypeDecor(ctx->expr()),
            .src = resultCode.addr,
        });
    }

    code = code || instruction::RETURN();
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitSwap(AslParser::SwapContext *ctx) {

    DEBUG_ENTER();
    instructionList code;

    CodeAttribs arg0 = std::any_cast<CodeAttribs>(visit(ctx->left_expr(0)));
    CodeAttribs arg1 = std::any_cast<CodeAttribs>(visit(ctx->left_expr(1)));
    code = code || arg0.code || arg1.code;


    TypesMgr::TypeId arg0Ty = getTypeDecor(ctx->left_expr(0));
    TypesMgr::TypeId arg1Ty = getTypeDecor(ctx->left_expr(1));


    if (Types.isArrayTy(arg0Ty) && Types.isArrayTy(arg1Ty)) {
        TypesMgr::TypeId elemTypeArg0 = Types.getArrayElemType(arg0Ty);
        TypesMgr::TypeId elemTypeArg1 = Types.getArrayElemType(arg1Ty);

        std::string index = newTemp();

        instructionList body;
        // temp = arg0[i]
        std::string temp = newTemp();
        body = body || inst(Assign {
            .dstType = elemTypeArg0,
            .dst = temp,
            .dstOffset = "",

            .srcType = elemTypeArg0,
            .src = arg0.addr,
            .srcOffset = index
        });
        
        // arg0[i] = arg1[i]
        body = body || inst(Assign {
            .dstType = elemTypeArg0,
            .dst = arg0.addr,
            .dstOffset = index,

            .srcType = elemTypeArg1,
            .src = arg1.addr,
            .srcOffset = index,
        });

        // arg1[i] = temp
        body = body || inst(Assign {
            .dstType = elemTypeArg1,
            .dst = arg1.addr,
            .dstOffset = index,

            .srcType = elemTypeArg0,
            .src = temp,
            .srcOffset = "",
        });
        
        // for i in 0..size { dst[i] = src[i]; }
        size_t size = Types.getArraySize(arg0Ty);
        code = code || inst(ForRange {
            .start = "0",
            .end = std::to_string(size),
            .index=index,
            .body = body,
        });


    } else {
        // temp = arg0
        std::string temp = newTemp();
        code = code || inst(Assign {
            .dstType = arg0Ty,
            .dst = temp,
            .dstOffset = "",

            .srcType = arg0Ty,
            .src = arg0.addr,
            .srcOffset = arg0.offs,
        });
        
        // arg0 = arg1
        code = code || inst(Assign {
            .dstType = arg0Ty,
            .dst = arg0.addr,
            .dstOffset = arg0.offs,

            .srcType = arg1Ty,
            .src = arg1.addr,
            .srcOffset = arg1.offs,
        });

        // arg1 = temp
        code = code || inst(Assign {
            .dstType = arg1Ty,
            .dst = arg1.addr,
            .dstOffset = arg1.offs,

            .srcType = arg0Ty,
            .src = temp,
        });
    }
   
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitSwitch(AslParser::SwitchContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    std::string exitLabel = "switch_exit_" + codeCounters.newLabelIF();

    CodeAttribs &&value = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    code = code || value.code;

    for (size_t i = 0; i < ctx->switch_case().size(); ++i) {

        CodeAttribs &&case_value = std::any_cast<CodeAttribs>(visit(ctx->switch_case(i)->expr()));
        code = code || case_value.code;

        instructionList &&case_body = std::any_cast<instructionList>(visit(ctx->switch_case(i)->statements()));

        std::string condition = newTemp();
        code = code || instruction::EQ(condition, value.addr, case_value.addr);

        code = code || inst(If {
            .condition = condition,
            .trueBody = case_body || instruction::UJUMP(exitLabel),
            .falseBody = {},
        });
    }

    if (ctx->statements())
        code = code || std::any_cast<instructionList>(visit(ctx->statements()));

    code = code || instruction::LABEL(exitLabel);

    DEBUG_EXIT();

    return code;
}



std::any CodeGenVisitor::visitSetIdent(AslParser::SetIdentContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAts = std::any_cast<CodeAttribs>(visit(ctx->ident()));
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitSetArray(AslParser::SetArrayContext *ctx) {
    DEBUG_ENTER();
    instructionList code;

    CodeAttribs &&codAts1 = std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string array = codAts1.addr;
    instructionList &code1 = codAts1.code;

    // Handle array by reference
    if (Symbols.isParameterClass(array)) {
        std::string arrayAddr = newTemp();
        code = code || instruction::LOAD(arrayAddr, array);
        array = arrayAddr;
    }
    
    CodeAttribs &&codAts2 = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string index = codAts2.addr;
    instructionList &code2 = codAts2.code;

    code = code || code1 || code2;

    CodeAttribs codAts(array, index, code);

    DEBUG_EXIT();
    return codAts;
}

// std::any CodeGenVisitor::visitLeft_expr(AslParser::Left_exprContext* ctx) {
//   DEBUG_ENTER();
//   CodeAttribs&& codAts = std::any_cast<CodeAttribs>(visit(ctx->ident()));
//   DEBUG_EXIT();
//   return codAts;
// }

std::any CodeGenVisitor::visitParent(AslParser::ParentContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAts = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitGetArray(AslParser::GetArrayContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&arrayCode = std::any_cast<CodeAttribs>(visit(ctx->ident()));
    CodeAttribs &&indexCode = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    
    CodeAttribs arrayAccess = inst_load(arrayCode.addr, indexCode.addr);
    arrayAccess.code = arrayCode.code || indexCode.code || arrayAccess.code;

    DEBUG_EXIT();
    return arrayAccess;
}

std::any CodeGenVisitor::visitFuncCall(AslParser::FuncCallContext *ctx) {
    DEBUG_ENTER();

    std::vector<CodeAttribs> arguments;
    std::vector<TypesMgr::TypeId> argumentsTypes;
    std::string result = newTemp();
    
    for (size_t i = 0; i < ctx->expr().size(); ++i) {
        arguments.push_back(std::any_cast<CodeAttribs>(visit(ctx->expr(i))));
        argumentsTypes.push_back(getTypeDecor(ctx->expr(i)));
    }

    CodeAttribs codAts(result, "", inst(FuncCall {
        .functionType = getTypeDecor(ctx->ident()),
        .functionName = ctx->ident()->getText(),
        .arguments = arguments,
        .argumentsTypes = argumentsTypes,
        .result = result,
    }));


    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitArithmetic(AslParser::ArithmeticContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAt1 = std::any_cast<CodeAttribs>(visit(ctx->expr(0)));
    std::string lhs = codAt1.addr;
    instructionList &code1 = codAt1.code;

    CodeAttribs &&codAt2 = std::any_cast<CodeAttribs>(visit(ctx->expr(1)));

    std::string rhs = codAt2.addr;
    instructionList &code2 = codAt2.code;
    instructionList &&code = code1 || code2;
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr(0));
    TypesMgr::TypeId t2 = getTypeDecor(ctx->expr(1));
    TypesMgr::TypeId t = getTypeDecor(ctx);

    std::string temp = newTemp();
    if (Types.isFloatTy(t)) {
        if (Types.isIntegerTy(t1)) {
            std::string temp = newTemp();
            code = code || instruction::FLOAT(temp, lhs);
            lhs = temp;
        }
        if (Types.isIntegerTy(t2)) {
            std::string temp = newTemp();
            code = code || instruction::FLOAT(temp, rhs);
            rhs = temp;
        }

        if (ctx->MUL())
            code = code || instruction::FMUL(temp, lhs, rhs);
        else if (ctx->DIV())
            code = code || instruction::FDIV(temp, lhs, rhs);
        else if (ctx->PLUS())
            code = code || instruction::FADD(temp, lhs, rhs);
        else if (ctx->MINUS())
            code = code || instruction::FSUB(temp, lhs, rhs);
    } else {
        if (ctx->MUL())
            code = code || instruction::MUL(temp, lhs, rhs);
        else if (ctx->DIV())
            code = code || instruction::DIV(temp, lhs, rhs);
        else if (ctx->MOD()) {
            // a % b = a - b*int(a/b)
            code = code || instruction::DIV(temp, lhs, rhs);
            code = code || instruction::MUL(temp, rhs, temp);
            code = code || instruction::SUB(temp, lhs, temp);
        } else if (ctx->PLUS())
            code = code || instruction::ADD(temp, lhs, rhs);
        else if (ctx->MINUS())
            code = code || instruction::SUB(temp, lhs, rhs);
    }

    CodeAttribs codAts(temp, "", code);
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitUnary(AslParser::UnaryContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAt = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string var = codAt.addr;
    instructionList &code = codAt.code;

    TypesMgr::TypeId t = getTypeDecor(ctx->expr());
    std::string result = var;

    if (ctx->NOT()) {
        result = newTemp();
        code = code || instruction::NOT(result, var);
    } else if (ctx->MINUS()) {
        result = newTemp();
        if (Types.isIntegerTy(t))
            code = code || instruction::NEG(result, var);
        else if (Types.isFloatTy(t))
            code = code || instruction::FNEG(result, var);
        
    }

    CodeAttribs codAts(result, "", code);
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitRelational(AslParser::RelationalContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAt1 = std::any_cast<CodeAttribs>(visit(ctx->expr(0)));
    std::string lhs = codAt1.addr;
    instructionList &code1 = codAt1.code;

    CodeAttribs &&codAt2 = std::any_cast<CodeAttribs>(visit(ctx->expr(1)));
    std::string rhs = codAt2.addr;
    instructionList &code2 = codAt2.code;
    instructionList &&code = code1 || code2;

    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr(0));
    TypesMgr::TypeId t2 = getTypeDecor(ctx->expr(1));
    // TypesMgr::TypeId  t = getTypeDecor(ctx);
    std::string temp = newTemp();
    if (Types.isFloatTy(t1) || Types.isFloatTy(t2))
    {
        if (Types.isIntegerTy(t1)) {
            std::string temp = newTemp();
            code = code || instruction::FLOAT(temp, lhs);
            lhs = temp;
        }
        if (Types.isIntegerTy(t2)) {
            std::string temp = newTemp();
            code = code || instruction::FLOAT(temp, rhs);
            rhs = temp;
        }

        if (ctx->EQUAL())
            code = code || instruction::FEQ(temp, lhs, rhs);
        else if (ctx->NE()) {
            code = code || instruction::FEQ(temp, lhs, rhs);
            code = code || instruction::NOT(temp, temp);
        } else if (ctx->LE())
            code = code || instruction::FLE(temp, lhs, rhs);
        else if (ctx->LT())
            code = code || instruction::FLT(temp, lhs, rhs);
        else if (ctx->GE()) {
            code = code || instruction::FLT(temp, lhs, rhs);
            code = code || instruction::NOT(temp, temp);
        } else if (ctx->GT()) {
            code = code || instruction::FLE(temp, lhs, rhs);
            code = code || instruction::NOT(temp, temp);
        }
    } else {
        if (ctx->EQUAL())
            code = code || instruction::EQ(temp, lhs, rhs);
        else if (ctx->NE()) {
            code = code || instruction::EQ(temp, lhs, rhs);
            code = code || instruction::NOT(temp, temp);
        } else if (ctx->LE())
            code = code || instruction::LE(temp, lhs, rhs);
        else if (ctx->LT())
            code = code || instruction::LT(temp, lhs, rhs);
        else if (ctx->GE()) {
            code = code || instruction::LT(temp, lhs, rhs);
            code = code || instruction::NOT(temp, temp);
        } else if (ctx->GT()) {
            code = code || instruction::LE(temp, lhs, rhs);
            code = code || instruction::NOT(temp, temp);
        }
    }

    CodeAttribs codAts(temp, "", code);
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitLogical(AslParser::LogicalContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAt1 = std::any_cast<CodeAttribs>(visit(ctx->expr(0)));
    std::string addr1 = codAt1.addr;
    instructionList &code1 = codAt1.code;
    CodeAttribs &&codAt2 = std::any_cast<CodeAttribs>(visit(ctx->expr(1)));
    std::string addr2 = codAt2.addr;
    instructionList &code2 = codAt2.code;
    instructionList &&code = code1 || code2;
    // TypesMgr::TypeId t1 = getTypeDecor(ctx->expr(0));
    // TypesMgr::TypeId t2 = getTypeDecor(ctx->expr(1));
    // TypesMgr::TypeId  t = getTypeDecor(ctx);
    std::string temp = newTemp();
    if (ctx->AND())
        code = code || instruction::AND(temp, addr1, addr2);
    else if (ctx->OR())
        code = code || instruction::OR(temp, addr1, addr2);

    CodeAttribs codAts(temp, "", code);
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitValue(AslParser::ValueContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    std::string temp = newTemp();
    if (ctx->INTVAL())
        code = instruction::ILOAD(temp, ctx->getText());
    else if (ctx->FLOATVAL())
        code = instruction::FLOAD(temp, ctx->getText());
    else if (ctx->FALSE())
        code = instruction::ILOAD(temp, "0");
    else if (ctx->TRUE())
        code = instruction::ILOAD(temp, "1");
    else if (ctx->CHARVAL())
        code = instruction::LOAD(temp, ctx->getText());

    CodeAttribs codAts(temp, "", code);
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitExprIdent(AslParser::ExprIdentContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAts = std::any_cast<CodeAttribs>(visit(ctx->ident()));
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitIdent(AslParser::IdentContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs codAts(ctx->ID()->getText(), "", instructionList());
    DEBUG_EXIT();
    return codAts;
}

// Getters for the necessary tree node atributes:

//   Scope and Type
SymTable::ScopeId
CodeGenVisitor::getScopeDecor(antlr4::ParserRuleContext *ctx) const {
    return Decorations.getScope(ctx);
}
TypesMgr::TypeId
CodeGenVisitor::getTypeDecor(antlr4::ParserRuleContext *ctx) const {
    return Decorations.getType(ctx);
}

// Constructors of the class CodeAttribs:
//
CodeGenVisitor::CodeAttribs::CodeAttribs(const std::string &addr,
                                         const std::string &offs,
                                         instructionList &code)
    : addr{addr}, offs{offs}, code{code} {}

CodeGenVisitor::CodeAttribs::CodeAttribs(const std::string &addr,
                                         const std::string &offs,
                                         instructionList &&code)
    : addr{addr}, offs{offs}, code{code} {}
