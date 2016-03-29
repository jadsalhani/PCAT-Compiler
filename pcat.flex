import java_cup.runtime.*;

%%

%public
%class PCATScanner
%implements ReservedWords, Delimiters, Operators, TokenLiteral

%unicode

%line
%column

%cup

%{
StringBuilder string = new StringBuilder();
OperatorHandler operatorHandler = new OperatorHandler();
SymbolTable symbolTable = new SymbolTable();

private int symbol(String token) {
SymbolManager symbol = new SymbolManager(token, yyline+1, yycolumn+1);
System.out.println(symbol.toString());
if(token.equals("EOF")){
System.out.println("Printing symbol table entries:");
symbolTable.printTokens();
}
return 1;
}

private int symbol(String token, Object value) {
SymbolManager symbol = new SymbolManager(token, yyline+1, yycolumn+1, value);
System.out.println(symbol.toString());
symbolTable.addToken(value.toString(), token);
return 1;
}

private int symbol(String token, Object value, OperatorHandler operatorHandler) {
SymbolManager symbol = new SymbolManager(token, yyline+1, yycolumn+1, value, operatorHandler);
System.out.println(symbol.toString());
symbolTable.addToken(token, operatorHandler.getOperagetTokenValue(token));
return 1;
}

public boolean getEOF(){
    return zzAtEOF;
}

%}

/* required rules */
letter = [a-zA-Z]
digit = [0-9]

/* identifiers */
Identifier = {letter}({letter} | {digit})*

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {PcatComment}

PcatComment = "(*" {InputCharacter}* "*)" {LineTerminator}?
PcatErrorComment = "(*" {InputCharacter}* {LineTerminator}?
//TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
//EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
//DocumentationComment = "/*" "*"+ [^/*] ~"*/"

/* integer literals */
IntegerLiteral    = {digit}+
RealLiteral       = {digit}+[.]{digit}*

/* string and character literals */
StringCharacter = [^\r\n\"\\]

CommentError = {PcatErrorComment}
IdentifierError = {digit}|[_]{Identifier}
%state STRING, CHARLITERAL

%%

<YYINITIAL> {

/* keywords */
"AND"                          { return symbol(AND, yytext()); }
"ARRAY"                        { return symbol(ARRAY, yytext()); }
"BEGIN"                        { return symbol(BEGIN, yytext()); }
"BY"                           { return symbol(BY, yytext()); }
"DIV"                          { return symbol(DIV, yytext()); }
"DO"                           { return symbol(DO, yytext()); }
"ELSEIF"                       { return symbol(ELSEIF, yytext()); }
"END"                          { return symbol(END, yytext()); }
"EXIT"                         { return symbol(EXIT, yytext()); }
"IS"                           { return symbol(IS, yytext()); }
"LOOP"                         { return symbol(LOOP, yytext()); }
"MOD"                          { return symbol(MOD, yytext()); }
"OF"                           { return symbol(OF, yytext()); }
"PROCEDURE"                    { return symbol(PROCEDURE, yytext()); }
"PROGRAM"                      { return symbol(PROGRAM, yytext()); }
"READ"                         { return symbol(READ, yytext()); }
"RECORD"                       { return symbol(RECORD, yytext()); }
"THEN"                         { return symbol(THEN, yytext()); }
"TO"                           { return symbol(TO, yytext()); }
"TYPE"                         { return symbol(TYPE, yytext()); }
"VAR"                          { return symbol(VAR, yytext()); }
"WRITE"                        { return symbol(WRITE, yytext()); }
"DO"                           { return symbol(DO, yytext()); }
"ELSE"                         { return symbol(ELSE, yytext()); }
"FOR"                          { return symbol(FOR, yytext()); }
"IF"                           { return symbol(IF, yytext()); }
"RETURN"                       { return symbol(RETURN, yytext()); }
"WHILE"                        { return symbol(WHILE, yytext()); }


/* numeric literals */
{IntegerLiteral}               { return symbol(INTEGER_LITERAL, new Integer(yytext())); }
{RealLiteral}                  { return symbol(REAL_LITERAL, new Float((yytext()))); }

/* comments */
{Comment}                      { /* ignore */ }

/* error */
{CommentError}                 { throw new RuntimeException("Error at line " + yyline +
                                        ", column " + yycolumn + ", Dangling comment. Exiting"); }

/* whitespace */
{WhiteSpace}                   { /* ignore */ }

/* separators */ //Done
"("                            { return symbol(LEFT_PAREN, yytext()); }
")"                            { return symbol(RIGHT_PAREN, yytext()); }
"{"                            { return symbol(LEFT_BRACE, yytext()); }
"}"                            { return symbol(RIGHT_BRACE, yytext()); }
"["                            { return symbol(LEFT_BRACKET, yytext()); }
"]"                            { return symbol(RIGHT_BRACKET, yytext()); }
";"                            { return symbol(SEMI_COLON, yytext()); }
","                            { return symbol(COMMA, yytext()); }
"."                            { return symbol(DOT, yytext()); }
":"                            { return symbol(COLON, yytext()); }

/* operators */ //Done
"="                            { return symbol(EQUAL, yytext(), operatorHandler); }
">"                            { return symbol(GREATER_THAN, yytext(), operatorHandler); }
"<"                            { return symbol(LESS_THAN, yytext(), operatorHandler); }
"<>"                           { return symbol(NOT_EQUAL, yytext(), operatorHandler); }
"<="                           { return symbol(LESS_THAN_EQUAL, yytext(), operatorHandler); }
">="                           { return symbol(GREATER_THAN_EQUAL, yytext()); }
":="                           { return symbol(ASSIGN, yytext(), operatorHandler); }
"+"                            { return symbol(ADD, yytext(), operatorHandler); }
"-"                            { return symbol(SUBSTRACT, yytext(), operatorHandler); }
"*"                            { return symbol(TIMES, yytext(), operatorHandler); }
"/"                            { return symbol(DIVIDE, yytext(), operatorHandler); }
"AND"                          { return symbol(AND, yytext()); }
"OR"                           { return symbol(OR, yytext()); }
"MOD"                          { return symbol(MOD, yytext()); }

/* identifiers */
{Identifier}                   { return symbol(IDENTIFIER_LIT, yytext()); }

{IdentifierError}              { System.out.println(new RuntimeException("Error at line " + yyline
                                    + ",column " + yycolumn + ", Identifier "
                                    + yytext() + " must begin with a letter. Skipping")); }

/* string literal */
\"                             { yybegin(STRING); string.setLength(0); }

/* character literal */
\'                             { yybegin(CHARLITERAL); }

}

<STRING> {
\"                             { yybegin(YYINITIAL); return symbol(STRING_LITERAL, string.toString()); }

{StringCharacter}+             { string.append( yytext() ); }

/* escape sequences */
"\\b"                          { string.append( '\b' ); }
"\\t"                          { string.append( '\t' ); }
"\\n"                          { string.append( '\n' ); }
"\\f"                          { string.append( '\f' ); }
"\\r"                          { string.append( '\r' ); }
"\\\""                         { string.append( '\"' ); }
"\\'"                          { string.append( '\'' ); }
"\\\\"                         { string.append( '\\' ); }

/* error cases */
\\.                            { System.out.println(new RuntimeException("Illegal escape sequence \""+yytext()+"\"")); }
{LineTerminator}               { System.out.println(new RuntimeException("Error at line " + yyline
                                    + ", column " + yycolumn +
                                    ", Unterminated string. Skipping")); }
}

<CHARLITERAL> {
/* error cases */
\\.                            { System.out.println(new RuntimeException("Illegal escape sequence \""+yytext()+"\"")); }
{LineTerminator}               { System.out.println(new RuntimeException("Unterminated character literal at end of line")); }
}

/* error fallback */
[^]                              { System.out.println(new RuntimeException("Unrecognized Symbol \""+yytext()+
                                    "\" at line "+yyline+", column "+yycolumn+ ". Skipping")); }

<<EOF>>                          { return symbol("EOF"); }
