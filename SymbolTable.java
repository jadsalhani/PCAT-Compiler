import java.util.ArrayList;

public class SymbolTable {

    private ArrayList<LexicalToken> tokens;

    public SymbolTable(){
        tokens = new ArrayList<LexicalToken>();
    }

    public void addToken(String lexeme, String token){
        LexicalToken tokenObject = new LexicalToken(lexeme, token);
        tokens.add(tokenObject);
    }

    public LexicalToken getToken(int index){
        return tokens.get(index);
    }

    public void printTokens(){
        for (int i = 0; i < tokens.size(); i++) {
            System.out.println(i + ": " + tokens.get(i).toString());
        }
    }


}

class LexicalToken{
    private String lexeme;
    private String token;

    public LexicalToken(String lex, String tok){
        this.lexeme = lex;
        this.token = tok;
    }

    public String getLexeme() {
        return lexeme;
    }

    public String getToken() {
        return token;
    }

    @Override
    public String toString(){
        return getLexeme() + ", " + getToken();
    }
}
