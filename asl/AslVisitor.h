
// Generated from Asl.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"
#include "AslParser.h"



/**
 * This class defines an abstract visitor for a parse tree
 * produced by AslParser.
 */
class  AslVisitor : public antlr4::tree::AbstractParseTreeVisitor {
public:

  /**
   * Visit parse trees produced by AslParser.
   */
    virtual std::any visitProgram(AslParser::ProgramContext *context) = 0;

    virtual std::any visitFunction(AslParser::FunctionContext *context) = 0;

    virtual std::any visitParameters(AslParser::ParametersContext *context) = 0;

    virtual std::any visitParameter(AslParser::ParameterContext *context) = 0;

    virtual std::any visitDeclarations(AslParser::DeclarationsContext *context) = 0;

    virtual std::any visitVariable_decl(AslParser::Variable_declContext *context) = 0;

    virtual std::any visitType(AslParser::TypeContext *context) = 0;

    virtual std::any visitStatements(AslParser::StatementsContext *context) = 0;

    virtual std::any visitAssignStmt(AslParser::AssignStmtContext *context) = 0;

    virtual std::any visitIfStmt(AslParser::IfStmtContext *context) = 0;

    virtual std::any visitWhileStmt(AslParser::WhileStmtContext *context) = 0;

    virtual std::any visitProcCall(AslParser::ProcCallContext *context) = 0;

    virtual std::any visitReadStmt(AslParser::ReadStmtContext *context) = 0;

    virtual std::any visitWriteExpr(AslParser::WriteExprContext *context) = 0;

    virtual std::any visitWriteString(AslParser::WriteStringContext *context) = 0;

    virtual std::any visitReturn(AslParser::ReturnContext *context) = 0;

    virtual std::any visitLeft_expr(AslParser::Left_exprContext *context) = 0;

    virtual std::any visitParent(AslParser::ParentContext *context) = 0;

    virtual std::any visitExprIdent(AslParser::ExprIdentContext *context) = 0;

    virtual std::any visitArithmetic(AslParser::ArithmeticContext *context) = 0;

    virtual std::any visitRelational(AslParser::RelationalContext *context) = 0;

    virtual std::any visitUnary(AslParser::UnaryContext *context) = 0;

    virtual std::any visitValue(AslParser::ValueContext *context) = 0;

    virtual std::any visitLogical(AslParser::LogicalContext *context) = 0;

    virtual std::any visitIdent(AslParser::IdentContext *context) = 0;


};

