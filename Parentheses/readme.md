# Parentheses removal function

## Description
Given a string containing an expression, return the expression with unnecessary parentheses removed.  
For example:  
f("1*(2+(3*(4+5)))") ===> "1*(2+3*(4+5))"  
f("2 + (3 / -5)") ===> "2 + 3 / -5"  
f("x+(y+z)+(t+(v+w))") ===> "x+y+z+t+v+w"

## Extra Limitation when implementation

### Vailid Operator
There are four acceptable operators:
``` 
 + - * /
Order of operations: multiplication and division before addition and subtraction.
```

### Minus `-` symbol
`-1`, `1+-1`, `1 + -1`, `aa + -bb` are acceptable accoding to the example 2. `-` is a part of the symbols, not a operator.
When `-` is a part of the symbols, spaces between `-` and symbols are not allowed.
ex: `1+ - 1` is invalid.

### Vaild parentheses
There two kinds of parentheses: open and close
```
( )
```

### Parentheses
Invalid: `a(a)`, `1(1)`

### Sample valid and invalid data
1. valid data in unit tests: `/src/main/resources/data.csv`
2. invalid data in unit tests: `invalid_data.csv`

### Limitation summary
| Operators | Rules | Invalid | 
|-----------|-------|------------------------------|
| `+`| `+`, `-`, `*`, `/`, and `(` can not be the preceding char of it; and cannot be leading chars(ignored space chars)| ` +1`, `+1`, `(+1)`, `1+ + 1` |
| `-` | if `-` as a part of operand, there are no spaces between the operand| `- 1`, `1+ - 1`, `(- 1)` |
| `*` |`+`, `-`, `*`, `/`, and `(` can not be the preceding char of it; and cannot be leading chars(ignored space chars) | ` *1`, `*1`, `(*1)`, `1+ * 1`  |
| `/` |`+`, `-`, `*`, `/`, and `(` can not be the preceding char of it; and cannot be leading chars(ignored space chars) | ` /1`, `/1`, `(/1)`, `1+ / 1`  |
|`+`, `-`, `*`, `/`| Cannot be in the tail of a expression (ignored space chars)|`1+1+`, `1+1-`,`1+1*`,`1+1/`,
| `(` |operands can not be the preceding char(ignored space chars) of `(` | `a(a)`, `22(22)`, `33 (33)`|
| `(` `)` | Open Parentheses must be closed | `(`, `()(`|
| `(` `)` | Open Parentheses must be closed in the correct order|`)(`, `)`, `(()(` |
| operand | there are no spaces between the operand | `1 1+1`, `a b`, `a*(b + c d)`|

## Special Cases
Because `-` can behind `*`, and `/`, need to introduce special cases
-(1*2) can be simplified -1*2
### Special valid cases
1. `1*-2`, `1/-2`
2. `1*-(2+3)`, `1/-(2+3)`

### Special removal parentheses expressions
1. `-(1/2) -> -1/2`
2. `-(1*2) -> -1*2`
3. `-(1*2)*(3/4) -> -1*2*3/4`
4. `-(1*2/(2+3)) -> -1*2/(2+3)`
5. `5*-(1*2/(2+3)) -> 5*-1*2/(2+3)`
6. `5*-((1+2)*3)/7 -> 5*-(1+2)*3/7`
7. `5*-((1+2)*3)/-7 -> 5*-(1+2)*3/-7`
8. `1+((-2))" -> "1+(-2)`

Also, we can refer to `/src/main/resources/data.csv` to check the test cases.


## How to execute the program (Choose one)
### Run the executable JAR:
1. Make sure you have installed the java environment in your machine and the java version is > java 8
   oracle jdk: https://www.oracle.com/java/technologies/downloads/#java17
   open jdk: https://jdk.java.net/java-se-ri/17
   mac:
   java 8: `brew install openjdk@8`
   java 11: `brew install openjdk@11`
   java 17: `brew install openjdk@17`
2. Execute jar
   `java -jar Parentheses-0.3.0.jar`

### Run in docker
Need to download the image from Docker hub and make sure connection to the internet is available)
1. Download the docker from https://www.docker.com/products/docker-desktop/ and install it.
   mac:  `brew install docker`
2. Execute `docker run --rm -i liun03/parentheses_service:0.3.0` and we can see (ignored the docker pull messages):
```
******************************
Please input a valid mathematical expression or type 'exit' to exit the program:
1 + (2)
Remove unnecessary parentheses: 1 + 2
```
**NOTE: When we type "up", "down", "left", and "right" in the terminal, there are some unexpected chars appeared.
Recommend that coping the expression somewhere and paste it to the terminal.**

## (Optional) Build  project
Before build the project, make sure that JAVA is installed in the environment (> JAVA 8)
### Build the maven codes
```
./mvnw clean install
```
After build the project, we can find the executable jar file `Parentheses-0.3.0.jar` in the `./target`.
We have no extra lib for the executable jar and we do not handle it. If we want to add extra libs for the jar, we should modify the POM.

### Build image
Befor build the image, you should execute `Build the maven codes` and generate the executable jar.
It is a sample image build and you can modify the name and tag by yourself.
```
docker build -t liun03/parentheses_service:0.3.0 .
```