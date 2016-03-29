import java.util.Map;
import java.util.TreeMap;

/**
 * Created by jadsalhani on 2/18/16.
 */
public class OperatorHandler implements Operators{

    private Map<String, Operator> operatorMap = new TreeMap<String, Operator>();

    public OperatorHandler(){
        operatorMap.put(NOT, new Operator("TOK_OP_NOT", "OP_NOT"));
        operatorMap.put(OR, new Operator("TOK_OP_NOT", "OP_NOT"));
        operatorMap.put(AND, new Operator("TOK_OP_AND", "OP_AND"));
        operatorMap.put(EQUAL, new Operator("TOK_OP_REL", "OP_EQ"));
        operatorMap.put(NOT_EQUAL , new Operator("TOK_OP_REL", "OP_NE"));
        operatorMap.put(LESS_THAN, new Operator("TOK_OP_REL", "OP_LT"));
        operatorMap.put(LESS_THAN_EQUAL , new Operator("TOK_OP_REL", "OP_LE"));
        operatorMap.put(GREATER_THAN, new Operator("TOK_OP_REL", "OP_GT"));
        operatorMap.put(GREATER_THAN_EQUAL , new Operator("TOK_OP_REL", "OP_GE"));
        operatorMap.put(ASSIGN, new Operator("TOK_OP_ASSIGN", "OP_ASSIGN"));
        operatorMap.put(ADD, new Operator("TOK_OP_ADD", "OP_ADD_PLUS"));
        operatorMap.put(SUBSTRACT, new Operator("TOK_OP_ADD", "OP_ADD_MINUS"));
        operatorMap.put(TIMES, new Operator("TOK_OP_TIMES", "OP_MUL_TIMES"));
        operatorMap.put(DIVIDE, new Operator("TOK_OP_TIMES", "OP_MUL_DIV"));
        operatorMap.put(IDIV, new Operator("TOK_OP_TIMES", "OP_MUL_IDIV"));
        operatorMap.put(MOD, new Operator("TOK_OP_TIMES", "OP_MUL_MOD"));

    }

    public Operator getOperator(String key){
        return operatorMap.get(key);
    }

    public String getOperatorTokenName(String key){
        return operatorMap.get(key).getTokenName();
    }

    public String getOperagetTokenValue(String key){
        return operatorMap.get(key).getTokenValue();
    }
}


class Operator{
    private String tokenName;
    private String tokenValue;

    public Operator(String name, String value){
        this.tokenName = name;
        this.tokenValue = value;
    }

    public String getTokenName() {
        return tokenName;
    }

    public String getTokenValue() {
        return tokenValue;
    }
}
