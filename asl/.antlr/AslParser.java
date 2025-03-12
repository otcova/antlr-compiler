// Generated from /dades/otger.comas/CL/practica/asl/Asl.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class AslParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, ASSIGN=8, EQUAL=9, 
		NE=10, LT=11, GT=12, LE=13, GE=14, AND=15, OR=16, NOT=17, PLUS=18, MINUS=19, 
		MUL=20, DIV=21, VAR=22, INT=23, FLOAT=24, BOOL=25, CHAR=26, IF=27, THEN=28, 
		ELSE=29, ENDIF=30, WHILE=31, DO=32, ENDWHILE=33, FUNC=34, ENDFUNC=35, 
		RETURN=36, READ=37, WRITE=38, BOOLVAL=39, INTVAL=40, FLOATVAL=41, CHARVAL=42, 
		ID=43, STRING=44, COMMENT=45, WS=46;
	public static final int
		RULE_program = 0, RULE_function = 1, RULE_parameters = 2, RULE_parameter = 3, 
		RULE_declarations = 4, RULE_variable_decl = 5, RULE_type = 6, RULE_statements = 7, 
		RULE_statement = 8, RULE_left_expr = 9, RULE_expr = 10, RULE_ident = 11;
	private static String[] makeRuleNames() {
		return new String[] {
			"program", "function", "parameters", "parameter", "declarations", "variable_decl", 
			"type", "statements", "statement", "left_expr", "expr", "ident"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'('", "')'", "':'", "','", "';'", "'['", "']'", "'='", "'=='", 
			"'!='", "'<'", "'>'", "'<='", "'>='", "'and'", "'or'", "'not'", "'+'", 
			"'-'", "'*'", "'/'", "'var'", "'int'", "'float'", "'bool'", "'char'", 
			"'if'", "'then'", "'else'", "'endif'", "'while'", "'do'", "'endwhile'", 
			"'func'", "'endfunc'", "'return'", "'read'", "'write'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, "ASSIGN", "EQUAL", "NE", 
			"LT", "GT", "LE", "GE", "AND", "OR", "NOT", "PLUS", "MINUS", "MUL", "DIV", 
			"VAR", "INT", "FLOAT", "BOOL", "CHAR", "IF", "THEN", "ELSE", "ENDIF", 
			"WHILE", "DO", "ENDWHILE", "FUNC", "ENDFUNC", "RETURN", "READ", "WRITE", 
			"BOOLVAL", "INTVAL", "FLOATVAL", "CHARVAL", "ID", "STRING", "COMMENT", 
			"WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Asl.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public AslParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ProgramContext extends ParserRuleContext {
		public TerminalNode EOF() { return getToken(AslParser.EOF, 0); }
		public List<FunctionContext> function() {
			return getRuleContexts(FunctionContext.class);
		}
		public FunctionContext function(int i) {
			return getRuleContext(FunctionContext.class,i);
		}
		public ProgramContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_program; }
	}

	public final ProgramContext program() throws RecognitionException {
		ProgramContext _localctx = new ProgramContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_program);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(25); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(24);
				function();
				}
				}
				setState(27); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==FUNC );
			setState(29);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class FunctionContext extends ParserRuleContext {
		public TerminalNode FUNC() { return getToken(AslParser.FUNC, 0); }
		public TerminalNode ID() { return getToken(AslParser.ID, 0); }
		public ParametersContext parameters() {
			return getRuleContext(ParametersContext.class,0);
		}
		public DeclarationsContext declarations() {
			return getRuleContext(DeclarationsContext.class,0);
		}
		public StatementsContext statements() {
			return getRuleContext(StatementsContext.class,0);
		}
		public TerminalNode ENDFUNC() { return getToken(AslParser.ENDFUNC, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public FunctionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function; }
	}

	public final FunctionContext function() throws RecognitionException {
		FunctionContext _localctx = new FunctionContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_function);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(31);
			match(FUNC);
			setState(32);
			match(ID);
			setState(33);
			match(T__0);
			setState(34);
			parameters();
			setState(35);
			match(T__1);
			setState(38);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__2) {
				{
				setState(36);
				match(T__2);
				setState(37);
				type();
				}
			}

			setState(40);
			declarations();
			setState(41);
			statements();
			setState(42);
			match(ENDFUNC);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ParametersContext extends ParserRuleContext {
		public List<ParameterContext> parameter() {
			return getRuleContexts(ParameterContext.class);
		}
		public ParameterContext parameter(int i) {
			return getRuleContext(ParameterContext.class,i);
		}
		public ParametersContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parameters; }
	}

	public final ParametersContext parameters() throws RecognitionException {
		ParametersContext _localctx = new ParametersContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_parameters);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(52);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==ID) {
				{
				setState(44);
				parameter();
				setState(49);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__3) {
					{
					{
					setState(45);
					match(T__3);
					setState(46);
					parameter();
					}
					}
					setState(51);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ParameterContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(AslParser.ID, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public ParameterContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parameter; }
	}

	public final ParameterContext parameter() throws RecognitionException {
		ParameterContext _localctx = new ParameterContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_parameter);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(54);
			match(ID);
			setState(55);
			match(T__2);
			setState(56);
			type();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class DeclarationsContext extends ParserRuleContext {
		public List<Variable_declContext> variable_decl() {
			return getRuleContexts(Variable_declContext.class);
		}
		public Variable_declContext variable_decl(int i) {
			return getRuleContext(Variable_declContext.class,i);
		}
		public DeclarationsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_declarations; }
	}

	public final DeclarationsContext declarations() throws RecognitionException {
		DeclarationsContext _localctx = new DeclarationsContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_declarations);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(61);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==VAR) {
				{
				{
				setState(58);
				variable_decl();
				}
				}
				setState(63);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Variable_declContext extends ParserRuleContext {
		public TerminalNode VAR() { return getToken(AslParser.VAR, 0); }
		public List<TerminalNode> ID() { return getTokens(AslParser.ID); }
		public TerminalNode ID(int i) {
			return getToken(AslParser.ID, i);
		}
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Variable_declContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variable_decl; }
	}

	public final Variable_declContext variable_decl() throws RecognitionException {
		Variable_declContext _localctx = new Variable_declContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_variable_decl);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(64);
			match(VAR);
			setState(65);
			match(ID);
			setState(70);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__3) {
				{
				{
				setState(66);
				match(T__3);
				setState(67);
				match(ID);
				}
				}
				setState(72);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(73);
			match(T__2);
			setState(74);
			type();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class TypeContext extends ParserRuleContext {
		public TerminalNode INT() { return getToken(AslParser.INT, 0); }
		public TerminalNode FLOAT() { return getToken(AslParser.FLOAT, 0); }
		public TerminalNode BOOL() { return getToken(AslParser.BOOL, 0); }
		public TerminalNode CHAR() { return getToken(AslParser.CHAR, 0); }
		public TypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type; }
	}

	public final TypeContext type() throws RecognitionException {
		TypeContext _localctx = new TypeContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(76);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & 125829120L) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class StatementsContext extends ParserRuleContext {
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public StatementsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statements; }
	}

	public final StatementsContext statements() throws RecognitionException {
		StatementsContext _localctx = new StatementsContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_statements);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(81);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & 9279411060736L) != 0)) {
				{
				{
				setState(78);
				statement();
				}
				}
				setState(83);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class StatementContext extends ParserRuleContext {
		public StatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statement; }
	 
		public StatementContext() { }
		public void copyFrom(StatementContext ctx) {
			super.copyFrom(ctx);
		}
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ProcCallContext extends StatementContext {
		public IdentContext ident() {
			return getRuleContext(IdentContext.class,0);
		}
		public ProcCallContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class WriteExprContext extends StatementContext {
		public TerminalNode WRITE() { return getToken(AslParser.WRITE, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public WriteExprContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class WhileStmtContext extends StatementContext {
		public TerminalNode WHILE() { return getToken(AslParser.WHILE, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode DO() { return getToken(AslParser.DO, 0); }
		public StatementsContext statements() {
			return getRuleContext(StatementsContext.class,0);
		}
		public TerminalNode ENDWHILE() { return getToken(AslParser.ENDWHILE, 0); }
		public WhileStmtContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class IfStmtContext extends StatementContext {
		public TerminalNode IF() { return getToken(AslParser.IF, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode THEN() { return getToken(AslParser.THEN, 0); }
		public List<StatementsContext> statements() {
			return getRuleContexts(StatementsContext.class);
		}
		public StatementsContext statements(int i) {
			return getRuleContext(StatementsContext.class,i);
		}
		public TerminalNode ENDIF() { return getToken(AslParser.ENDIF, 0); }
		public TerminalNode ELSE() { return getToken(AslParser.ELSE, 0); }
		public IfStmtContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ReadStmtContext extends StatementContext {
		public TerminalNode READ() { return getToken(AslParser.READ, 0); }
		public Left_exprContext left_expr() {
			return getRuleContext(Left_exprContext.class,0);
		}
		public ReadStmtContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class AssignStmtContext extends StatementContext {
		public Left_exprContext left_expr() {
			return getRuleContext(Left_exprContext.class,0);
		}
		public TerminalNode ASSIGN() { return getToken(AslParser.ASSIGN, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public AssignStmtContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class WriteStringContext extends StatementContext {
		public TerminalNode WRITE() { return getToken(AslParser.WRITE, 0); }
		public TerminalNode STRING() { return getToken(AslParser.STRING, 0); }
		public WriteStringContext(StatementContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ReturnContext extends StatementContext {
		public TerminalNode RETURN() { return getToken(AslParser.RETURN, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ReturnContext(StatementContext ctx) { copyFrom(ctx); }
	}

	public final StatementContext statement() throws RecognitionException {
		StatementContext _localctx = new StatementContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_statement);
		int _la;
		try {
			setState(126);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,9,_ctx) ) {
			case 1:
				_localctx = new AssignStmtContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(84);
				left_expr();
				setState(85);
				match(ASSIGN);
				setState(86);
				expr(0);
				setState(87);
				match(T__4);
				}
				break;
			case 2:
				_localctx = new IfStmtContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(89);
				match(IF);
				setState(90);
				expr(0);
				setState(91);
				match(THEN);
				setState(92);
				statements();
				setState(95);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==ELSE) {
					{
					setState(93);
					match(ELSE);
					setState(94);
					statements();
					}
				}

				setState(97);
				match(ENDIF);
				}
				break;
			case 3:
				_localctx = new WhileStmtContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(99);
				match(WHILE);
				setState(100);
				expr(0);
				setState(101);
				match(DO);
				setState(102);
				statements();
				setState(103);
				match(ENDWHILE);
				}
				break;
			case 4:
				_localctx = new ProcCallContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(105);
				ident();
				setState(106);
				match(T__0);
				setState(107);
				match(T__1);
				setState(108);
				match(T__4);
				}
				break;
			case 5:
				_localctx = new ReadStmtContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(110);
				match(READ);
				setState(111);
				left_expr();
				setState(112);
				match(T__4);
				}
				break;
			case 6:
				_localctx = new WriteExprContext(_localctx);
				enterOuterAlt(_localctx, 6);
				{
				setState(114);
				match(WRITE);
				setState(115);
				expr(0);
				setState(116);
				match(T__4);
				}
				break;
			case 7:
				_localctx = new WriteStringContext(_localctx);
				enterOuterAlt(_localctx, 7);
				{
				setState(118);
				match(WRITE);
				setState(119);
				match(STRING);
				setState(120);
				match(T__4);
				}
				break;
			case 8:
				_localctx = new ReturnContext(_localctx);
				enterOuterAlt(_localctx, 8);
				{
				setState(121);
				match(RETURN);
				setState(123);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 17042431148034L) != 0)) {
					{
					setState(122);
					expr(0);
					}
				}

				setState(125);
				match(T__4);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Left_exprContext extends ParserRuleContext {
		public IdentContext ident() {
			return getRuleContext(IdentContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public Left_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_left_expr; }
	}

	public final Left_exprContext left_expr() throws RecognitionException {
		Left_exprContext _localctx = new Left_exprContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_left_expr);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(128);
			ident();
			setState(133);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__5) {
				{
				setState(129);
				match(T__5);
				setState(130);
				expr(0);
				setState(131);
				match(T__6);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ExprContext extends ParserRuleContext {
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
	 
		public ExprContext() { }
		public void copyFrom(ExprContext ctx) {
			super.copyFrom(ctx);
		}
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ParentContext extends ExprContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ParentContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class GetArrayContext extends ExprContext {
		public IdentContext ident() {
			return getRuleContext(IdentContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public GetArrayContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ExprIdentContext extends ExprContext {
		public IdentContext ident() {
			return getRuleContext(IdentContext.class,0);
		}
		public ExprIdentContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ArithmeticContext extends ExprContext {
		public Token op;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode MUL() { return getToken(AslParser.MUL, 0); }
		public TerminalNode DIV() { return getToken(AslParser.DIV, 0); }
		public TerminalNode PLUS() { return getToken(AslParser.PLUS, 0); }
		public TerminalNode MINUS() { return getToken(AslParser.MINUS, 0); }
		public ArithmeticContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class RelationalContext extends ExprContext {
		public Token op;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode EQUAL() { return getToken(AslParser.EQUAL, 0); }
		public TerminalNode NE() { return getToken(AslParser.NE, 0); }
		public TerminalNode LT() { return getToken(AslParser.LT, 0); }
		public TerminalNode GT() { return getToken(AslParser.GT, 0); }
		public TerminalNode LE() { return getToken(AslParser.LE, 0); }
		public TerminalNode GE() { return getToken(AslParser.GE, 0); }
		public RelationalContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class UnaryContext extends ExprContext {
		public Token op;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode NOT() { return getToken(AslParser.NOT, 0); }
		public TerminalNode PLUS() { return getToken(AslParser.PLUS, 0); }
		public TerminalNode MINUS() { return getToken(AslParser.MINUS, 0); }
		public UnaryContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class FuncCallContext extends ExprContext {
		public IdentContext ident() {
			return getRuleContext(IdentContext.class,0);
		}
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public FuncCallContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class ValueContext extends ExprContext {
		public TerminalNode INTVAL() { return getToken(AslParser.INTVAL, 0); }
		public TerminalNode FLOATVAL() { return getToken(AslParser.FLOATVAL, 0); }
		public TerminalNode CHARVAL() { return getToken(AslParser.CHARVAL, 0); }
		public TerminalNode BOOLVAL() { return getToken(AslParser.BOOLVAL, 0); }
		public ValueContext(ExprContext ctx) { copyFrom(ctx); }
	}
	@SuppressWarnings("CheckReturnValue")
	public static class LogicalContext extends ExprContext {
		public Token op;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode AND() { return getToken(AslParser.AND, 0); }
		public TerminalNode OR() { return getToken(AslParser.OR, 0); }
		public LogicalContext(ExprContext ctx) { copyFrom(ctx); }
	}

	public final ExprContext expr() throws RecognitionException {
		return expr(0);
	}

	private ExprContext expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExprContext _localctx = new ExprContext(_ctx, _parentState);
		ExprContext _prevctx = _localctx;
		int _startState = 20;
		enterRecursionRule(_localctx, 20, RULE_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(166);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,13,_ctx) ) {
			case 1:
				{
				_localctx = new UnaryContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;

				setState(136);
				((UnaryContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & 917504L) != 0)) ) {
					((UnaryContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(137);
				expr(14);
				}
				break;
			case 2:
				{
				_localctx = new ValueContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(138);
				match(INTVAL);
				}
				break;
			case 3:
				{
				_localctx = new ValueContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(139);
				match(FLOATVAL);
				}
				break;
			case 4:
				{
				_localctx = new ValueContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(140);
				match(CHARVAL);
				}
				break;
			case 5:
				{
				_localctx = new ValueContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(141);
				match(BOOLVAL);
				}
				break;
			case 6:
				{
				_localctx = new GetArrayContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(142);
				ident();
				setState(143);
				match(T__5);
				setState(144);
				expr(0);
				setState(145);
				match(T__6);
				}
				break;
			case 7:
				{
				_localctx = new FuncCallContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(147);
				ident();
				setState(148);
				match(T__0);
				setState(157);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 17042431148034L) != 0)) {
					{
					setState(149);
					expr(0);
					setState(154);
					_errHandler.sync(this);
					_la = _input.LA(1);
					while (_la==T__3) {
						{
						{
						setState(150);
						match(T__3);
						setState(151);
						expr(0);
						}
						}
						setState(156);
						_errHandler.sync(this);
						_la = _input.LA(1);
					}
					}
				}

				setState(159);
				match(T__1);
				}
				break;
			case 8:
				{
				_localctx = new ExprIdentContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(161);
				ident();
				}
				break;
			case 9:
				{
				_localctx = new ParentContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(162);
				match(T__0);
				setState(163);
				expr(0);
				setState(164);
				match(T__1);
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(185);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(183);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,14,_ctx) ) {
					case 1:
						{
						_localctx = new ArithmeticContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(168);
						if (!(precpred(_ctx, 13))) throw new FailedPredicateException(this, "precpred(_ctx, 13)");
						setState(169);
						((ArithmeticContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==MUL || _la==DIV) ) {
							((ArithmeticContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(170);
						expr(14);
						}
						break;
					case 2:
						{
						_localctx = new ArithmeticContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(171);
						if (!(precpred(_ctx, 12))) throw new FailedPredicateException(this, "precpred(_ctx, 12)");
						setState(172);
						((ArithmeticContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==PLUS || _la==MINUS) ) {
							((ArithmeticContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(173);
						expr(13);
						}
						break;
					case 3:
						{
						_localctx = new RelationalContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(174);
						if (!(precpred(_ctx, 11))) throw new FailedPredicateException(this, "precpred(_ctx, 11)");
						setState(175);
						((RelationalContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & 32256L) != 0)) ) {
							((RelationalContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(176);
						expr(12);
						}
						break;
					case 4:
						{
						_localctx = new LogicalContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(177);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						setState(178);
						((LogicalContext)_localctx).op = match(AND);
						setState(179);
						expr(11);
						}
						break;
					case 5:
						{
						_localctx = new LogicalContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(180);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(181);
						((LogicalContext)_localctx).op = match(OR);
						setState(182);
						expr(10);
						}
						break;
					}
					} 
				}
				setState(187);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class IdentContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(AslParser.ID, 0); }
		public IdentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ident; }
	}

	public final IdentContext ident() throws RecognitionException {
		IdentContext _localctx = new IdentContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_ident);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(188);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 10:
			return expr_sempred((ExprContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 13);
		case 1:
			return precpred(_ctx, 12);
		case 2:
			return precpred(_ctx, 11);
		case 3:
			return precpred(_ctx, 10);
		case 4:
			return precpred(_ctx, 9);
		}
		return true;
	}

	public static final String _serializedATN =
		"\u0004\u0001.\u00bf\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001\u0002"+
		"\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004\u0007\u0004\u0002"+
		"\u0005\u0007\u0005\u0002\u0006\u0007\u0006\u0002\u0007\u0007\u0007\u0002"+
		"\b\u0007\b\u0002\t\u0007\t\u0002\n\u0007\n\u0002\u000b\u0007\u000b\u0001"+
		"\u0000\u0004\u0000\u001a\b\u0000\u000b\u0000\f\u0000\u001b\u0001\u0000"+
		"\u0001\u0000\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0003\u0001\'\b\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0002\u0001\u0002\u0001\u0002\u0005\u0002"+
		"0\b\u0002\n\u0002\f\u00023\t\u0002\u0003\u00025\b\u0002\u0001\u0003\u0001"+
		"\u0003\u0001\u0003\u0001\u0003\u0001\u0004\u0005\u0004<\b\u0004\n\u0004"+
		"\f\u0004?\t\u0004\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0005"+
		"\u0005E\b\u0005\n\u0005\f\u0005H\t\u0005\u0001\u0005\u0001\u0005\u0001"+
		"\u0005\u0001\u0006\u0001\u0006\u0001\u0007\u0005\u0007P\b\u0007\n\u0007"+
		"\f\u0007S\t\u0007\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001"+
		"\b\u0001\b\u0001\b\u0001\b\u0001\b\u0003\b`\b\b\u0001\b\u0001\b\u0001"+
		"\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001"+
		"\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001"+
		"\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0003\b|\b\b\u0001\b\u0003"+
		"\b\u007f\b\b\u0001\t\u0001\t\u0001\t\u0001\t\u0001\t\u0003\t\u0086\b\t"+
		"\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001"+
		"\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0005"+
		"\n\u0099\b\n\n\n\f\n\u009c\t\n\u0003\n\u009e\b\n\u0001\n\u0001\n\u0001"+
		"\n\u0001\n\u0001\n\u0001\n\u0001\n\u0003\n\u00a7\b\n\u0001\n\u0001\n\u0001"+
		"\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001"+
		"\n\u0001\n\u0001\n\u0001\n\u0005\n\u00b8\b\n\n\n\f\n\u00bb\t\n\u0001\u000b"+
		"\u0001\u000b\u0001\u000b\u0000\u0001\u0014\f\u0000\u0002\u0004\u0006\b"+
		"\n\f\u000e\u0010\u0012\u0014\u0016\u0000\u0005\u0001\u0000\u0017\u001a"+
		"\u0001\u0000\u0011\u0013\u0001\u0000\u0014\u0015\u0001\u0000\u0012\u0013"+
		"\u0001\u0000\t\u000e\u00d2\u0000\u0019\u0001\u0000\u0000\u0000\u0002\u001f"+
		"\u0001\u0000\u0000\u0000\u00044\u0001\u0000\u0000\u0000\u00066\u0001\u0000"+
		"\u0000\u0000\b=\u0001\u0000\u0000\u0000\n@\u0001\u0000\u0000\u0000\fL"+
		"\u0001\u0000\u0000\u0000\u000eQ\u0001\u0000\u0000\u0000\u0010~\u0001\u0000"+
		"\u0000\u0000\u0012\u0080\u0001\u0000\u0000\u0000\u0014\u00a6\u0001\u0000"+
		"\u0000\u0000\u0016\u00bc\u0001\u0000\u0000\u0000\u0018\u001a\u0003\u0002"+
		"\u0001\u0000\u0019\u0018\u0001\u0000\u0000\u0000\u001a\u001b\u0001\u0000"+
		"\u0000\u0000\u001b\u0019\u0001\u0000\u0000\u0000\u001b\u001c\u0001\u0000"+
		"\u0000\u0000\u001c\u001d\u0001\u0000\u0000\u0000\u001d\u001e\u0005\u0000"+
		"\u0000\u0001\u001e\u0001\u0001\u0000\u0000\u0000\u001f \u0005\"\u0000"+
		"\u0000 !\u0005+\u0000\u0000!\"\u0005\u0001\u0000\u0000\"#\u0003\u0004"+
		"\u0002\u0000#&\u0005\u0002\u0000\u0000$%\u0005\u0003\u0000\u0000%\'\u0003"+
		"\f\u0006\u0000&$\u0001\u0000\u0000\u0000&\'\u0001\u0000\u0000\u0000\'"+
		"(\u0001\u0000\u0000\u0000()\u0003\b\u0004\u0000)*\u0003\u000e\u0007\u0000"+
		"*+\u0005#\u0000\u0000+\u0003\u0001\u0000\u0000\u0000,1\u0003\u0006\u0003"+
		"\u0000-.\u0005\u0004\u0000\u0000.0\u0003\u0006\u0003\u0000/-\u0001\u0000"+
		"\u0000\u000003\u0001\u0000\u0000\u00001/\u0001\u0000\u0000\u000012\u0001"+
		"\u0000\u0000\u000025\u0001\u0000\u0000\u000031\u0001\u0000\u0000\u0000"+
		"4,\u0001\u0000\u0000\u000045\u0001\u0000\u0000\u00005\u0005\u0001\u0000"+
		"\u0000\u000067\u0005+\u0000\u000078\u0005\u0003\u0000\u000089\u0003\f"+
		"\u0006\u00009\u0007\u0001\u0000\u0000\u0000:<\u0003\n\u0005\u0000;:\u0001"+
		"\u0000\u0000\u0000<?\u0001\u0000\u0000\u0000=;\u0001\u0000\u0000\u0000"+
		"=>\u0001\u0000\u0000\u0000>\t\u0001\u0000\u0000\u0000?=\u0001\u0000\u0000"+
		"\u0000@A\u0005\u0016\u0000\u0000AF\u0005+\u0000\u0000BC\u0005\u0004\u0000"+
		"\u0000CE\u0005+\u0000\u0000DB\u0001\u0000\u0000\u0000EH\u0001\u0000\u0000"+
		"\u0000FD\u0001\u0000\u0000\u0000FG\u0001\u0000\u0000\u0000GI\u0001\u0000"+
		"\u0000\u0000HF\u0001\u0000\u0000\u0000IJ\u0005\u0003\u0000\u0000JK\u0003"+
		"\f\u0006\u0000K\u000b\u0001\u0000\u0000\u0000LM\u0007\u0000\u0000\u0000"+
		"M\r\u0001\u0000\u0000\u0000NP\u0003\u0010\b\u0000ON\u0001\u0000\u0000"+
		"\u0000PS\u0001\u0000\u0000\u0000QO\u0001\u0000\u0000\u0000QR\u0001\u0000"+
		"\u0000\u0000R\u000f\u0001\u0000\u0000\u0000SQ\u0001\u0000\u0000\u0000"+
		"TU\u0003\u0012\t\u0000UV\u0005\b\u0000\u0000VW\u0003\u0014\n\u0000WX\u0005"+
		"\u0005\u0000\u0000X\u007f\u0001\u0000\u0000\u0000YZ\u0005\u001b\u0000"+
		"\u0000Z[\u0003\u0014\n\u0000[\\\u0005\u001c\u0000\u0000\\_\u0003\u000e"+
		"\u0007\u0000]^\u0005\u001d\u0000\u0000^`\u0003\u000e\u0007\u0000_]\u0001"+
		"\u0000\u0000\u0000_`\u0001\u0000\u0000\u0000`a\u0001\u0000\u0000\u0000"+
		"ab\u0005\u001e\u0000\u0000b\u007f\u0001\u0000\u0000\u0000cd\u0005\u001f"+
		"\u0000\u0000de\u0003\u0014\n\u0000ef\u0005 \u0000\u0000fg\u0003\u000e"+
		"\u0007\u0000gh\u0005!\u0000\u0000h\u007f\u0001\u0000\u0000\u0000ij\u0003"+
		"\u0016\u000b\u0000jk\u0005\u0001\u0000\u0000kl\u0005\u0002\u0000\u0000"+
		"lm\u0005\u0005\u0000\u0000m\u007f\u0001\u0000\u0000\u0000no\u0005%\u0000"+
		"\u0000op\u0003\u0012\t\u0000pq\u0005\u0005\u0000\u0000q\u007f\u0001\u0000"+
		"\u0000\u0000rs\u0005&\u0000\u0000st\u0003\u0014\n\u0000tu\u0005\u0005"+
		"\u0000\u0000u\u007f\u0001\u0000\u0000\u0000vw\u0005&\u0000\u0000wx\u0005"+
		",\u0000\u0000x\u007f\u0005\u0005\u0000\u0000y{\u0005$\u0000\u0000z|\u0003"+
		"\u0014\n\u0000{z\u0001\u0000\u0000\u0000{|\u0001\u0000\u0000\u0000|}\u0001"+
		"\u0000\u0000\u0000}\u007f\u0005\u0005\u0000\u0000~T\u0001\u0000\u0000"+
		"\u0000~Y\u0001\u0000\u0000\u0000~c\u0001\u0000\u0000\u0000~i\u0001\u0000"+
		"\u0000\u0000~n\u0001\u0000\u0000\u0000~r\u0001\u0000\u0000\u0000~v\u0001"+
		"\u0000\u0000\u0000~y\u0001\u0000\u0000\u0000\u007f\u0011\u0001\u0000\u0000"+
		"\u0000\u0080\u0085\u0003\u0016\u000b\u0000\u0081\u0082\u0005\u0006\u0000"+
		"\u0000\u0082\u0083\u0003\u0014\n\u0000\u0083\u0084\u0005\u0007\u0000\u0000"+
		"\u0084\u0086\u0001\u0000\u0000\u0000\u0085\u0081\u0001\u0000\u0000\u0000"+
		"\u0085\u0086\u0001\u0000\u0000\u0000\u0086\u0013\u0001\u0000\u0000\u0000"+
		"\u0087\u0088\u0006\n\uffff\uffff\u0000\u0088\u0089\u0007\u0001\u0000\u0000"+
		"\u0089\u00a7\u0003\u0014\n\u000e\u008a\u00a7\u0005(\u0000\u0000\u008b"+
		"\u00a7\u0005)\u0000\u0000\u008c\u00a7\u0005*\u0000\u0000\u008d\u00a7\u0005"+
		"\'\u0000\u0000\u008e\u008f\u0003\u0016\u000b\u0000\u008f\u0090\u0005\u0006"+
		"\u0000\u0000\u0090\u0091\u0003\u0014\n\u0000\u0091\u0092\u0005\u0007\u0000"+
		"\u0000\u0092\u00a7\u0001\u0000\u0000\u0000\u0093\u0094\u0003\u0016\u000b"+
		"\u0000\u0094\u009d\u0005\u0001\u0000\u0000\u0095\u009a\u0003\u0014\n\u0000"+
		"\u0096\u0097\u0005\u0004\u0000\u0000\u0097\u0099\u0003\u0014\n\u0000\u0098"+
		"\u0096\u0001\u0000\u0000\u0000\u0099\u009c\u0001\u0000\u0000\u0000\u009a"+
		"\u0098\u0001\u0000\u0000\u0000\u009a\u009b\u0001\u0000\u0000\u0000\u009b"+
		"\u009e\u0001\u0000\u0000\u0000\u009c\u009a\u0001\u0000\u0000\u0000\u009d"+
		"\u0095\u0001\u0000\u0000\u0000\u009d\u009e\u0001\u0000\u0000\u0000\u009e"+
		"\u009f\u0001\u0000\u0000\u0000\u009f\u00a0\u0005\u0002\u0000\u0000\u00a0"+
		"\u00a7\u0001\u0000\u0000\u0000\u00a1\u00a7\u0003\u0016\u000b\u0000\u00a2"+
		"\u00a3\u0005\u0001\u0000\u0000\u00a3\u00a4\u0003\u0014\n\u0000\u00a4\u00a5"+
		"\u0005\u0002\u0000\u0000\u00a5\u00a7\u0001\u0000\u0000\u0000\u00a6\u0087"+
		"\u0001\u0000\u0000\u0000\u00a6\u008a\u0001\u0000\u0000\u0000\u00a6\u008b"+
		"\u0001\u0000\u0000\u0000\u00a6\u008c\u0001\u0000\u0000\u0000\u00a6\u008d"+
		"\u0001\u0000\u0000\u0000\u00a6\u008e\u0001\u0000\u0000\u0000\u00a6\u0093"+
		"\u0001\u0000\u0000\u0000\u00a6\u00a1\u0001\u0000\u0000\u0000\u00a6\u00a2"+
		"\u0001\u0000\u0000\u0000\u00a7\u00b9\u0001\u0000\u0000\u0000\u00a8\u00a9"+
		"\n\r\u0000\u0000\u00a9\u00aa\u0007\u0002\u0000\u0000\u00aa\u00b8\u0003"+
		"\u0014\n\u000e\u00ab\u00ac\n\f\u0000\u0000\u00ac\u00ad\u0007\u0003\u0000"+
		"\u0000\u00ad\u00b8\u0003\u0014\n\r\u00ae\u00af\n\u000b\u0000\u0000\u00af"+
		"\u00b0\u0007\u0004\u0000\u0000\u00b0\u00b8\u0003\u0014\n\f\u00b1\u00b2"+
		"\n\n\u0000\u0000\u00b2\u00b3\u0005\u000f\u0000\u0000\u00b3\u00b8\u0003"+
		"\u0014\n\u000b\u00b4\u00b5\n\t\u0000\u0000\u00b5\u00b6\u0005\u0010\u0000"+
		"\u0000\u00b6\u00b8\u0003\u0014\n\n\u00b7\u00a8\u0001\u0000\u0000\u0000"+
		"\u00b7\u00ab\u0001\u0000\u0000\u0000\u00b7\u00ae\u0001\u0000\u0000\u0000"+
		"\u00b7\u00b1\u0001\u0000\u0000\u0000\u00b7\u00b4\u0001\u0000\u0000\u0000"+
		"\u00b8\u00bb\u0001\u0000\u0000\u0000\u00b9\u00b7\u0001\u0000\u0000\u0000"+
		"\u00b9\u00ba\u0001\u0000\u0000\u0000\u00ba\u0015\u0001\u0000\u0000\u0000"+
		"\u00bb\u00b9\u0001\u0000\u0000\u0000\u00bc\u00bd\u0005+\u0000\u0000\u00bd"+
		"\u0017\u0001\u0000\u0000\u0000\u0010\u001b&14=FQ_{~\u0085\u009a\u009d"+
		"\u00a6\u00b7\u00b9";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}