JFLAGS = -cp .
JC = javac
JAVA = java

CLASSES =   \
	Delimiters.java \
	Operators.java \
	OperatorHandler.java \
	ReservedWords.java \
	TokenLiteral.java \
	SymbolManager.java \
	SymbolTable.java \
	PCATScanner.java \
	Main.java

all: build

build:
	jflex pcat.flex
	$(JC) $(JFLAGS) $(CLASSES)

default: all

clean:
	$(RM) *.class PCATScanner.java PCATScanner.java~

test:
	$(JAVA) Main testfiles/test-scanner-01.pcat
	$(JAVA) Main testfiles/test-scanner-02.pcat
	$(JAVA) Main testfiles/test-scanner-03.pcat
	$(JAVA) Main testfiles/test-scanner-04.pcat
	$(JAVA) Main testfiles/test-scanner-05.pcat
