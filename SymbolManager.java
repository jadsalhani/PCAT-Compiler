public class SymbolManager {

    public String token;
    public int line;
    public int column;
    public Object tokenValue;
    public String operatorValue;

    public SymbolManager(String token, int lineNumber, int columnNumber){
        this.token = token;
        this.line = lineNumber;
        this.column = columnNumber;
    }

    public SymbolManager(String token, int lineNumber, int columnNumber, Object value){
        this.token = token;
        this.line = lineNumber;
        this.column = columnNumber;
        this.tokenValue = value;
    }

    public SymbolManager(String token, int lineNumber, int columnNumber, Object value, OperatorHandler operatorHandler){
        Operator op = operatorHandler.getOperator(token);
        this.token = op.getTokenName();
        this.line = lineNumber;
        this.column = columnNumber;
        this.tokenValue = value;
        this.operatorValue = op.getTokenValue();
    }

    @Override
    public String toString() {
        return this.token
                + ": line " + this.line
                + ", column " + this.column
                + ", value: " + this.tokenValue
                + ", "
                + (this.operatorValue== null ? "" : this.operatorValue);
    }
}
