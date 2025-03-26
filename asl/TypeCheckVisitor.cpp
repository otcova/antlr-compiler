//////////////////////////////////////////////////////////////////////
//
//    TypeCheckVisitor - Walk the parser tree to do the semantic
//                       typecheck for the Asl programming language
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

#include "TypeCheckVisitor.h"
#include "antlr4-runtime.h"

#include "../common/SemErrors.h"
#include "../common/SymTable.h"
#include "../common/TreeDecoration.h"
#include "../common/TypesMgr.h"

#include <iostream>
#include <string>

// uncomment the following line to enable debugging messages with DEBUG*
// #define DEBUG_BUILD
#include "../common/debug.h"

#define LOG(x) std::cerr << " ---- " << x << std::endl;

// using namespace std;

// Constructor
TypeCheckVisitor::TypeCheckVisitor(TypesMgr &Types, SymTable &Symbols,
                                   TreeDecoration &Decorations,
                                   SemErrors &Errors)
    : Types{Types}, Symbols{Symbols}, Decorations{Decorations}, Errors{Errors} {
}

// Accessor/Mutator to the attribute currFunctionType.
// Corresponds to the return type of the current function.
TypesMgr::TypeId TypeCheckVisitor::getCurrentFunctionTy() const {
    return currFunctionType;
}

// Corresponds to the return type of the current function.
void TypeCheckVisitor::setCurrentFunctionTy(TypesMgr::TypeId type) {
    currFunctionType = type;
}

// Methods to visit each kind of node:
//
std::any TypeCheckVisitor::visitProgram(AslParser::ProgramContext *ctx) {
    DEBUG_ENTER();

    SymTable::ScopeId sc = getScopeDecor(ctx);
    Symbols.pushThisScope(sc);

    for (auto ctxFunc : ctx->function())
        visit(ctxFunc);

    if (Symbols.noMainProperlyDeclared())
        Errors.noMainProperlyDeclared(ctx);

    Symbols.popScope();
    Errors.print();
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitFunction(AslParser::FunctionContext *ctx) {
    DEBUG_ENTER();

    SymTable::ScopeId sc = getScopeDecor(ctx);
    Symbols.pushThisScope(sc);

    TypesMgr::TypeId tRet = Types.createVoidTy();
    if (ctx->basic_type())
        tRet = getTypeDecor(ctx->basic_type());

    setCurrentFunctionTy(tRet);

    visit(ctx->statements());

    Symbols.popScope();
    DEBUG_EXIT();
    return 0;
}

// std::any TypeCheckVisitor::visitDeclarations(AslParser::DeclarationsContext
// *ctx) {
//   DEBUG_ENTER();
//   std::any r = visitChildren(ctx);
//   DEBUG_EXIT();
//   return r;
// }
//
// std::any TypeCheckVisitor::visitVariable_decl(AslParser::Variable_declContext
// *ctx) {
//   DEBUG_ENTER();
//   std::any r = visitChildren(ctx);
//   DEBUG_EXIT();
//   return r;
// }
//
// std::any TypeCheckVisitor::visitType(AslParser::TypeContext *ctx) {
//   DEBUG_ENTER();
//   std::any r = visitChildren(ctx);
//   DEBUG_EXIT();
//   return r;
// }

std::any TypeCheckVisitor::visitStatements(AslParser::StatementsContext *ctx) {
    DEBUG_ENTER();
    visitChildren(ctx);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitTryCatch(AslParser::TryCatchContext *ctx) {
    DEBUG_ENTER();
    visitChildren(ctx);

    for (size_t i = 0; i < ctx->expr().size(); i++) {
        TypesMgr::TypeId type = getTypeDecor(ctx->expr(i));

        if (!Types.isErrorTy(type) && !Types.isPrimitiveTy(type)) {
            Errors.catchCasesRequireBasicTypes(ctx->CATCH());
        }
    }

    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitThrow(AslParser::ThrowContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr());

    TypesMgr::TypeId type = getTypeDecor(ctx->expr());

    if (!Types.isErrorTy(type) && !Types.isPrimitiveTy(type)) {
        Errors.throwRequiresBasicType(ctx);
    }


    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitAssignStmt(AslParser::AssignStmtContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->left_expr());
    visit(ctx->expr());
    TypesMgr::TypeId lhs = getTypeDecor(ctx->left_expr());
    TypesMgr::TypeId rhs = getTypeDecor(ctx->expr());

    if ((not Types.isErrorTy(lhs)) and (not Types.isErrorTy(rhs)) and
        (not Types.copyableTypes(lhs, rhs)))
        Errors.incompatibleAssignment(ctx->ASSIGN());

    if ((not Types.isErrorTy(lhs)) and (not getIsLValueDecor(ctx->left_expr())))
        Errors.nonReferenceableLeftExpr(ctx->left_expr());

    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitIfStmt(AslParser::IfStmtContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr());
    if ((not Types.isErrorTy(t1)) and (not Types.isBooleanTy(t1)))
        Errors.booleanRequired(ctx);

    for (size_t i = 0; i < ctx->statements().size(); i++)
        visit(ctx->statements(i));

    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitWhileStmt(AslParser::WhileStmtContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr());
    if ((not Types.isErrorTy(t1)) and (not Types.isBooleanTy(t1)))
        Errors.booleanRequired(ctx);
    visit(ctx->statements());
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitReturn(AslParser::ReturnContext *ctx) {
    DEBUG_ENTER();

    TypesMgr::TypeId returnType = Types.createVoidTy();
    if (ctx->expr()) {
        visit(ctx->expr());
        returnType = getTypeDecor(ctx->expr());
    }

    TypesMgr::TypeId funcType = getCurrentFunctionTy();
    if (!Types.isErrorTy(returnType) and !Types.isErrorTy(funcType)) {
        if (!Types.copyableTypes(funcType, returnType))
            Errors.incompatibleReturn(ctx->RETURN());
    }

    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitProcCall(AslParser::ProcCallContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->ident());
    for (auto arg : ctx->expr())
        visit(arg);

    TypesMgr::TypeId funcType = getTypeDecor(ctx->ident());

    if (not Types.isErrorTy(funcType)) {

        if (not Types.isFunctionTy(funcType))
            Errors.isNotCallable(ctx->ident());
        else {

            auto &params = Types.getFuncParamsTypes(funcType);
            if (params.size() != ctx->expr().size())
                Errors.numberOfParameters(ctx->ident());

            for (size_t i = 0; i < std::min(params.size(), ctx->expr().size());
                 ++i) {
                TypesMgr::TypeId exprType = getTypeDecor(ctx->expr(i));
                TypesMgr::TypeId funcParamType = params[i];

                if (!Types.isErrorTy(exprType) and
                    !Types.equalTypes(funcParamType, exprType))
                    Errors.incompatibleParameter(ctx->expr(i), i + 1, ctx);
            }
        }
    }
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitReadStmt(AslParser::ReadStmtContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->left_expr());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->left_expr());
    if ((not Types.isErrorTy(t1)) and (not Types.isPrimitiveTy(t1)) and
        (not Types.isFunctionTy(t1)))
        Errors.readWriteRequireBasic(ctx);
    if ((not Types.isErrorTy(t1)) and (not getIsLValueDecor(ctx->left_expr())))
        Errors.nonReferenceableExpression(ctx);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitWriteExpr(AslParser::WriteExprContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr());
    if ((not Types.isErrorTy(t1)) and (not Types.isPrimitiveTy(t1)))
        Errors.readWriteRequireBasic(ctx);
    DEBUG_EXIT();
    return 0;
}

// std::any TypeCheckVisitor::visitWriteString(AslParser::WriteStringContext
// *ctx) {
//   DEBUG_ENTER();
//   std::any r = visitChildren(ctx);
//   DEBUG_EXIT();
//   return r;
// }

std::any TypeCheckVisitor::visitLeft_expr(AslParser::Left_exprContext *ctx) {
    DEBUG_ENTER();

    visit(ctx->ident());
    TypesMgr::TypeId varType = getTypeDecor(ctx->ident());
    putTypeDecor(ctx, varType);
    bool b = getIsLValueDecor(ctx->ident());
    putIsLValueDecor(ctx, b);

    // Array access
    if (ctx->expr()) {
        visit(ctx->expr());

        TypesMgr::TypeId indexType = getTypeDecor(ctx->expr());

        if (not Types.isErrorTy(indexType) &&
            not Types.isIntegerTy(indexType)) {
            Errors.nonIntegerIndexInArrayAccess(ctx->expr());
        }

        if (Types.isErrorTy(varType)) {
            putTypeDecor(ctx, Types.createErrorTy());
        } else {
            if (Types.isArrayTy(varType)) {
                TypesMgr::TypeId elementType = Types.getArrayElemType(varType);
                putTypeDecor(ctx, elementType);
            } else {
                Errors.nonArrayInArrayAccess(ctx->ident());
                putTypeDecor(ctx, Types.createErrorTy());
            }
        }
    }
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitUnary(AslParser::UnaryContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr());
    std::string oper = ctx->op->getText();

    if (not Types.isErrorTy(t1)) {
        if ((ctx->PLUS() || ctx->MINUS()) && not Types.isNumericTy(t1))
            Errors.incompatibleOperator(ctx->op);
        else if (ctx->NOT() && not Types.isBooleanTy(t1))
            Errors.incompatibleOperator(ctx->op);
    }

    putTypeDecor(ctx, Types.createIntegerTy());
    if (ctx->NOT())
        putTypeDecor(ctx, Types.createBooleanTy());
    putIsLValueDecor(ctx, false);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitArithmetic(AslParser::ArithmeticContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr(0));
    visit(ctx->expr(1));
    TypesMgr::TypeId lhs = getTypeDecor(ctx->expr(0));
    TypesMgr::TypeId rhs = getTypeDecor(ctx->expr(1));

    bool error = false;
    error = error || (!Types.isErrorTy(lhs) && !Types.isNumericTy(lhs));
    error = error || (!Types.isErrorTy(rhs) && !Types.isNumericTy(rhs));

    if (ctx->MOD()) {
        error = error || (!Types.isErrorTy(lhs) && !Types.isIntegerTy(lhs));
        error = error || (!Types.isErrorTy(rhs) && !Types.isIntegerTy(rhs));
    }

    if (error)
        Errors.incompatibleOperator(ctx->op);

    TypesMgr::TypeId resultTy = Types.createIntegerTy();
    if (Types.isFloatTy(lhs) or Types.isFloatTy(rhs))
        resultTy = Types.createFloatTy();

    putTypeDecor(ctx, resultTy);
    putIsLValueDecor(ctx, false);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitRelational(AslParser::RelationalContext *ctx) {
    DEBUG_ENTER();

    visit(ctx->expr(0));
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr(0));
    visit(ctx->expr(1));
    TypesMgr::TypeId t2 = getTypeDecor(ctx->expr(1));
    std::string oper = ctx->op->getText();

    if ((not Types.isErrorTy(t1)) and (not Types.isErrorTy(t2)) and
        (not Types.comparableTypes(t1, t2, oper)))
        Errors.incompatibleOperator(ctx->op);

    TypesMgr::TypeId t = Types.createBooleanTy();
    putTypeDecor(ctx, t);
    putIsLValueDecor(ctx, false);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitLogical(AslParser::LogicalContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr(0));
    visit(ctx->expr(1));

    TypesMgr::TypeId lhs = getTypeDecor(ctx->expr(0));
    TypesMgr::TypeId rhs = getTypeDecor(ctx->expr(1));

    if ((!Types.isErrorTy(lhs) and !Types.isBooleanTy(lhs)) or
        (!Types.isErrorTy(rhs) and !Types.isBooleanTy(rhs)))
        Errors.incompatibleOperator(ctx->op);

    putTypeDecor(ctx, Types.createBooleanTy());
    putIsLValueDecor(ctx, false);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitValue(AslParser::ValueContext *ctx) {
    DEBUG_ENTER();
    TypesMgr::TypeId t;

    if (ctx->INTVAL())
        t = Types.createIntegerTy();
    else if (ctx->FLOATVAL())
        t = Types.createFloatTy();
    else if (ctx->CHARVAL())
        t = Types.createCharacterTy();
    else if (ctx->BOOLVAL())
        t = Types.createBooleanTy();

    putTypeDecor(ctx, t);
    putIsLValueDecor(ctx, false);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitGetArray(AslParser::GetArrayContext *ctx) {
    DEBUG_ENTER();

    visit(ctx->ident());
    visit(ctx->expr());

    TypesMgr::TypeId arrayType = getTypeDecor(ctx->ident());
    TypesMgr::TypeId indexType = getTypeDecor(ctx->expr());

    if (not Types.isErrorTy(arrayType) && not Types.isArrayTy(arrayType)) {
        Errors.nonArrayInArrayAccess(ctx->ident());
        putTypeDecor(ctx, Types.createErrorTy());
    }

    if (not Types.isErrorTy(indexType) && not Types.isIntegerTy(indexType)) {
        Errors.nonIntegerIndexInArrayAccess(ctx->expr());
        putTypeDecor(ctx, Types.createErrorTy());
    }

    if (Types.isArrayTy(arrayType))
        putTypeDecor(ctx, Types.getArrayElemType(arrayType));

    bool b = getIsLValueDecor(ctx->ident());
    putIsLValueDecor(ctx, b);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitFuncCall(AslParser::FuncCallContext *ctx) {
    DEBUG_ENTER();

    visit(ctx->ident());
    for (auto arg : ctx->expr())
        visit(arg);

    TypesMgr::TypeId funcType = getTypeDecor(ctx->ident());

    if (not Types.isErrorTy(funcType)) {

        if (not Types.isFunctionTy(funcType))
            Errors.isNotCallable(ctx->ident());
        else {
            TypesMgr::TypeId funcReturnType = Types.getFuncReturnType(funcType);

            putTypeDecor(ctx, funcReturnType);

            if (Types.isVoidTy(funcReturnType)) {
                Errors.isNotFunction(ctx->ident());
                putTypeDecor(ctx, Types.createErrorTy());
            }

            auto &params = Types.getFuncParamsTypes(funcType);
            if (params.size() != ctx->expr().size())
                Errors.numberOfParameters(ctx->ident());

            for (size_t i = 0; i < std::min(params.size(), ctx->expr().size());
                 ++i) {
                TypesMgr::TypeId exprType = getTypeDecor(ctx->expr(i));
                TypesMgr::TypeId funcParamType = params[i];

                if (!Types.isErrorTy(exprType) and
                    !Types.copyableTypes(funcParamType, exprType)) {
                    Errors.incompatibleParameter(ctx->expr(i), i + 1, ctx);
                }
            }
        }
    }

    putIsLValueDecor(ctx, false);

    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitExprIdent(AslParser::ExprIdentContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->ident());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->ident());
    putTypeDecor(ctx, t1);

    bool b = getIsLValueDecor(ctx->ident());
    putIsLValueDecor(ctx, b);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitParent(AslParser::ParentContext *ctx) {
    DEBUG_ENTER();
    visit(ctx->expr());
    TypesMgr::TypeId t1 = getTypeDecor(ctx->expr());

    // may change
    // if ((not Types.isErrorTy(t1)) and (not Types.isPrimitiveTy(t1)))
    //   Errors.readWriteRequireBasic(ctx);
    putTypeDecor(ctx, t1);
    putIsLValueDecor(ctx, false);
    DEBUG_EXIT();
    return 0;
}

std::any TypeCheckVisitor::visitIdent(AslParser::IdentContext *ctx) {
    DEBUG_ENTER();
    std::string ident = ctx->getText();
    if (Symbols.findInStack(ident) == -1) {
        Errors.undeclaredIdent(ctx->ID());
        TypesMgr::TypeId te = Types.createErrorTy();
        putTypeDecor(ctx, te);
        putIsLValueDecor(ctx, true);
    } else {
        TypesMgr::TypeId t1 = Symbols.getType(ident);
        putTypeDecor(ctx, t1);
        if (Symbols.isFunctionClass(ident))
            putIsLValueDecor(ctx, false);
        else
            putIsLValueDecor(ctx, true);
    }
    DEBUG_EXIT();
    return 0;
}

// Getters for the necessary tree node atributes:
//   Scope, Type ans IsLValue
SymTable::ScopeId
TypeCheckVisitor::getScopeDecor(antlr4::ParserRuleContext *ctx) {
    return Decorations.getScope(ctx);
}
TypesMgr::TypeId
TypeCheckVisitor::getTypeDecor(antlr4::ParserRuleContext *ctx) {
    return Decorations.getType(ctx);
}
bool TypeCheckVisitor::getIsLValueDecor(antlr4::ParserRuleContext *ctx) {
    return Decorations.getIsLValue(ctx);
}

// Setters for the necessary tree node attributes:
//   Scope, Type ans IsLValue
void TypeCheckVisitor::putScopeDecor(antlr4::ParserRuleContext *ctx,
                                     SymTable::ScopeId s) {
    Decorations.putScope(ctx, s);
}
void TypeCheckVisitor::putTypeDecor(antlr4::ParserRuleContext *ctx,
                                    TypesMgr::TypeId t) {
    Decorations.putType(ctx, t);
}
void TypeCheckVisitor::putIsLValueDecor(antlr4::ParserRuleContext *ctx,
                                        bool b) {
    Decorations.putIsLValue(ctx, b);
}
