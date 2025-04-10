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
#include "antlr4-runtime.h"

#include "../common/SymTable.h"
#include "../common/TreeDecoration.h"
#include "../common/TypesMgr.h"
#include "../common/code.h"

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

    if (ctx->basic_type()) {
        var funcType = std::any_cast<var>(visit(ctx->basic_type()));
        var result = var("_result", funcType.type);
        subr.add_param(result.name, result.type);
    }

    // this nedd to change
    std::vector<var> &&pvars =
        std::any_cast<std::vector<var>>(visit(ctx->parameters()));
    for (auto &onevar : pvars) {
        subr.add_param(onevar.name, onevar.type);
    }
    // end of the thing to change

    std::vector<var> &&lvars =
        std::any_cast<std::vector<var>>(visit(ctx->declarations()));
    for (auto &onevar : lvars) {
        subr.add_var(onevar);
    }

    instructionList &&code =
        std::any_cast<instructionList>(visit(ctx->statements()));

    code = code || instruction(instruction::RETURN());

    subr.set_instructions(code);
    Symbols.popScope();
    DEBUG_EXIT();
    return subr;
}

std::any CodeGenVisitor::visitParameters(AslParser::ParametersContext *ctx) {
    std::vector<var> paramList;
    for (auto *paramCtx : ctx->parameter()) {
        var oneParam = std::any_cast<var>(visit(paramCtx));
        paramList.push_back(oneParam);
    }
    return paramList;
}

std::any CodeGenVisitor::visitParameter(AslParser::ParameterContext *ctx) {
    std::string name = ctx->ID()->getText();
    TypesMgr::TypeId tid = getTypeDecor(ctx->type());
    std::string typeStr = Types.to_string(tid);

    return var(name, typeStr);
}

std::any
CodeGenVisitor::visitDeclarations(AslParser::DeclarationsContext *ctx) {
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

std::any CodeGenVisitor::visitBasic_type(AslParser::Basic_typeContext *ctx) {
    DEBUG_ENTER();
    TypesMgr::TypeId typeId = getTypeDecor(ctx);
    std::string type = Types.to_string(typeId);

    DEBUG_EXIT();
    return var("funcType", type);
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
        instructionList &&codeS = std::any_cast<instructionList>(visit(stCtx));
        code = code || codeS;
    }
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitAssignStmt(AslParser::AssignStmtContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    CodeAttribs &&codAtsE1 =
        std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string addr1 = codAtsE1.addr;
    std::string           offs1 = codAtsE1.offs;
    instructionList &code1 = codAtsE1.code;

    TypesMgr::TypeId tid1 = getTypeDecor(ctx->left_expr());

    CodeAttribs &&codAtsE2 = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string addr2 = codAtsE2.addr;
    // std::string           offs2 = codAtsE2.offs;
    instructionList &code2 = codAtsE2.code;
    TypesMgr::TypeId tid2 = getTypeDecor(ctx->expr());

    if (Types.isIntegerTy(tid2) && Types.isFloatTy(tid1))
    {
        std::string temp = "%" + codeCounters.newTEMP();
        code = code || instruction::FLOAT(temp, addr2);
        addr2 = temp;
    }

    if (offs1 != "") // for array access
    {
        code = code1 || code2 || code || instruction::XLOAD(addr1, offs1, addr2);
    }
    // else if (Types.isArrayTy(tid2))
    //     code = code1 || code2 || instruction::LOADX(addr1, addr2, offs2);
    // else if (Types.isArrayTy(tid1) && Types.isArrayTy(tid2))
    // {   
    //     std::string temp = "%" + codeCounters.newTEMP();
    //     code = code1 || code2 || instruction::LOADX(temp, addr2, offs2); // temp = addr2[offs2]
    //     code = code || instruction::LOAD(addr1, temp);  // addr1 = temp
    // }
    else 
        code = code1 || code2 || code || instruction::LOAD(addr1, addr2);

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitIfStmt(AslParser::IfStmtContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    CodeAttribs &&codAtsE = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string addr1 = codAtsE.addr;
    instructionList &code1 = codAtsE.code;
    instructionList &&code2 =
        std::any_cast<instructionList>(visit(ctx->statements(0))); 


    std::string label = codeCounters.newLabelIF();
    std::string labelEndIf = "endif" + label;

    if (ctx->statements(1))
    {
        instructionList &&code3 =
            std::any_cast<instructionList>(visit(ctx->statements(1))); 
        
        std::string label = codeCounters.newLabelIF();
        std::string labelElse = "else" + label;

        code = code1 || instruction::FJUMP(addr1, labelElse) || code2 || instruction::UJUMP(labelEndIf) ||
            instruction::LABEL(labelElse) || code3 ||
            instruction::LABEL(labelEndIf);

    } else {
        code = code1 || instruction::FJUMP(addr1, labelEndIf) || code2 ||
                instruction::LABEL(labelEndIf);

    }

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitWhileStmt(AslParser::WhileStmtContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    CodeAttribs &&codAtsE = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string addr1 = codAtsE.addr;
    instructionList &code1 = codAtsE.code;

    instructionList &&code2 =
        std::any_cast<instructionList>(visit(ctx->statements()));

    std::string label = codeCounters.newLabelWHILE();

    std::string labelEndWhile = "endwhile" + label;
    std::string labelStartWhile = "while" + label;

    code = instruction::LABEL(labelStartWhile) || code1 ||
           instruction::FJUMP(addr1, labelEndWhile) || code2 ||
           instruction::UJUMP(labelStartWhile) ||
           instruction::LABEL(labelEndWhile);

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
        if (Types.isFloatTy(paramType))
        {
            std::string temp = "%" + codeCounters.newTEMP();
            code = code || instruction::FLOAT(temp, param.addr);
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

    CodeAttribs &&codAtsE = std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string addr1 = codAtsE.addr;
    std::string          offs1 = codAtsE.offs;
    instructionList &code1 = codAtsE.code;
    instructionList &code = code1;

    TypesMgr::TypeId tid1 = getTypeDecor(ctx->left_expr());

    if (Types.isIntegerTy(tid1))
        code = code1 || instruction::READI(addr1);
    else if (Types.isFloatTy(tid1))
        code = code1 || instruction::READF(addr1);
    else if (Types.isCharacterTy(tid1))
        code = code1 || instruction::READC(addr1);
    else if (Types.isBooleanTy(tid1))
        code = code1 || instruction::READI(addr1);

    if (offs1 != "") // for array access
        code = code1 || instruction::XLOAD(addr1, offs1, addr1);

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
        CodeAttribs &&codAts = std::any_cast<CodeAttribs>(visit(ctx->expr()));
        std::string val = codAts.addr;
        instructionList &code1 = codAts.code;

        code = code1 || instruction::LOAD("_result", val);
    }
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
    CodeAttribs &&codAts1 = std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string array = codAts1.addr;
    instructionList &code1 = codAts1.code;
    
    CodeAttribs &&codAts2 = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string index = codAts2.addr;
    instructionList &code2 = codAts2.code;

    instructionList &&code = code1 || code2;

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
    CodeAttribs &&codAts1 = std::any_cast<CodeAttribs>(visit(ctx->ident()));
    std::string array = codAts1.addr;
    instructionList &code1 = codAts1.code;
    
    CodeAttribs &&codAts2 = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string index = codAts2.addr;
    instructionList &code2 = codAts2.code;
    
    std::string temp = "%" + codeCounters.newTEMP();
    instructionList &&code = code1 || code2 || instruction::LOADX(temp, array, index);
    
    CodeAttribs codAts(temp, "", code);

    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitFuncCall(AslParser::FuncCallContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    std::string name = ctx->ident()->getText();

    code = code || instruction::PUSH(); // for saving the result

    for (size_t i = 0; i < ctx->expr().size(); ++i) {
        CodeAttribs &&param = std::any_cast<CodeAttribs>(visit(ctx->expr(i)));

        code = code || param.code;
        TypesMgr::TypeId paramType = Types.getParameterType(getTypeDecor(ctx->ident()), i);
        if (Types.isFloatTy(paramType) && Types.isIntegerTy(getTypeDecor(ctx->expr(i))))
        {
            std::string temp = "%" + codeCounters.newTEMP();
            code = code || instruction::FLOAT(temp, param.addr);
            param.addr = temp;
        }
        code = code || instruction::PUSH(param.addr);
    }

    code = code || instruction::CALL(name);

    for (size_t i = 0; i < ctx->expr().size(); ++i) {
        code = code || instruction::POP();
    }
    std::string temp = "%" + codeCounters.newTEMP();
    code = code || instruction::POP(temp); // for the result

    CodeAttribs codAts(temp, "", code);

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

    std::string temp = "%" + codeCounters.newTEMP();
    if (Types.isFloatTy(t)) {
        if (Types.isIntegerTy(t1)) {
            std::string temp = "%" + codeCounters.newTEMP();
            code = code || instruction::FLOAT(temp, lhs);
            lhs = temp;
        }
        if (Types.isIntegerTy(t2)) {
            std::string temp = "%" + codeCounters.newTEMP();
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
        result = "%" + codeCounters.newTEMP();
        code = code || instruction::NOT(result, var);
    } else if (ctx->MINUS()) {
        result = "%" + codeCounters.newTEMP();
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
    std::string temp = "%" + codeCounters.newTEMP();
    if (Types.isFloatTy(t1) || Types.isFloatTy(t2))
    {
        if (Types.isIntegerTy(t1)) {
            std::string temp = "%" + codeCounters.newTEMP();
            code = code || instruction::FLOAT(temp, lhs);
            lhs = temp;
        }
        if (Types.isIntegerTy(t2)) {
            std::string temp = "%" + codeCounters.newTEMP();
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
    std::string temp = "%" + codeCounters.newTEMP();
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
    std::string temp = "%" + codeCounters.newTEMP();
    if (ctx->INTVAL())
        code = instruction::ILOAD(temp, ctx->getText());
    else if (ctx->FLOATVAL())
        code = instruction::FLOAD(temp, ctx->getText());
    else if (ctx->BOOLVAL()) {
        if (ctx->getText() == "false")
            code = instruction::ILOAD(temp, "0");
        else if (ctx->getText() == "true")
            code = instruction::ILOAD(temp, "1");
    } else if (ctx->CHARVAL())
        code = instruction::CHLOAD(temp, ctx->getText());

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
