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

    std::vector<var> ids;
    for (size_t i = 0; i < ctx->ID().size(); i++)
        ids.push_back(var{ctx->ID(i)->getText(), Types.to_string(t1), size});

    return ids;
}

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
    // std::string           offs1 = codAtsE1.offs;
    instructionList &code1 = codAtsE1.code;
    // TypesMgr::TypeId tid1 = getTypeDecor(ctx->left_expr());
    CodeAttribs &&codAtsE2 = std::any_cast<CodeAttribs>(visit(ctx->expr()));
    std::string addr2 = codAtsE2.addr;
    // std::string           offs2 = codAtsE2.offs;
    instructionList &code2 = codAtsE2.code;
    // TypesMgr::TypeId tid2 = getTypeDecor(ctx->expr());
    code = code1 || code2 || instruction::LOAD(addr1, addr2);
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
        std::any_cast<instructionList>(visit(ctx->statements(0))); // TODO
    std::string label = codeCounters.newLabelIF();
    std::string labelEndIf = "endif" + label;
    code = code1 || instruction::FJUMP(addr1, labelEndIf) || code2 ||
           instruction::LABEL(labelEndIf);
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

    code = instruction::LABEL(labelStartWhile) || code1 || instruction::FJUMP(addr1, labelEndWhile) || 
             code2 || instruction::UJUMP(labelStartWhile) ||
          instruction::LABEL(labelEndWhile);

    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitProcCall(AslParser::ProcCallContext *ctx) {
    DEBUG_ENTER();
    instructionList code;
    // std::string name = ctx->ident()->ID()->getSymbol()->getText();
    std::string name = ctx->ident()->getText();
    code = instruction::CALL(name);
    DEBUG_EXIT();
    return code;
}

std::any CodeGenVisitor::visitReadStmt(AslParser::ReadStmtContext *ctx) {
    DEBUG_ENTER();

    CodeAttribs &&codAtsE = std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
    std::string addr1 = codAtsE.addr;
    // std::string          offs1 = codAtsE.offs;
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

std::any CodeGenVisitor::visitSetIdent(AslParser::SetIdentContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAts = std::any_cast<CodeAttribs>(visit(ctx->ident()));
    DEBUG_EXIT();
    return codAts;
}

std::any CodeGenVisitor::visitSetArray(AslParser::SetArrayContext *ctx) {
    DEBUG_ENTER();
    CodeAttribs &&codAts = std::any_cast<CodeAttribs>(visit(ctx->left_expr()));
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
    // TODO
}

std::any CodeGenVisitor::visitFuncCall(AslParser::FuncCallContext *ctx) {
    // TODO
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
    if (ctx->EQUAL())
        code = code || instruction::EQ(temp, addr1, addr2);
    else if (ctx->NE()) {
        code = code || instruction::EQ(temp, addr1, addr2);
        code = code || instruction::NOT(temp, temp);
    } else if (ctx->LE())
        code = code || instruction::LE(temp, addr1, addr2);
    else if (ctx->LT())
        code = code || instruction::LT(temp, addr1, addr2);
    else if (ctx->GE()) {
        code = code || instruction::LT(temp, addr1, addr2);
        code = code || instruction::NOT(temp, temp);
    } else if (ctx->GT()) {
        code = code || instruction::LE(temp, addr1, addr2);
        code = code || instruction::NOT(temp, temp);
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
