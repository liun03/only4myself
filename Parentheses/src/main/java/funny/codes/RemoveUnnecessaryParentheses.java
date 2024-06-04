package funny.codes;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;
import java.util.Stack;

public final class RemoveUnnecessaryParentheses {

  private final static char SPACE_CHAR = ' ';
  private final static char PLUS_CHAR = '+';
  private final static char MINUS_CHAR = '-';
  private final static char MULTIPLY_CHAR = '*';
  private final static char DIVIDE_CHAR = '/';
  private final static char OPEN_PAREN_CHAR = '(';
  private final static char CLOSE_PAREN_CHAR = ')';

  private final static Set<Character> BEFORE_OPEN_BRACKET_ACCEPT = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR, OPEN_PAREN_CHAR,
          SPACE_CHAR));
  private final static Set<Character> BEFORE_CLOSE_BRACKET_NON_ACCEPT = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR, OPEN_PAREN_CHAR));

  private final static Set<Character> OP_SET = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR));

  private final static Set<Character> CHECK_MINUS_AS_OPERAND = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR, OPEN_PAREN_CHAR));

  private final static Set<Character> BEFORE_PLUS_MULTIPLE_DIVIDE_NON_ACCEPT = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR, OPEN_PAREN_CHAR));

  private final static Set<Character> OP_PARENTHESES_SET = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR, OPEN_PAREN_CHAR));

  private final static Set<Character> OP_PARENTHESES_SPACE_SET = new HashSet<>(
      Arrays.asList(PLUS_CHAR, MINUS_CHAR, MULTIPLY_CHAR, DIVIDE_CHAR, OPEN_PAREN_CHAR, SPACE_CHAR));

  public static String removeUnnecessaryParentheses(String inputExpression) {
    int len = inputExpression.length();
    int[] belongToParenPos = new int[len];
    Stack<Integer> parenStack = new Stack<>();
    Set<Integer> plusMinusSet = new HashSet<>();
    Set<Integer> remaindedParensSet = new HashSet<>();
    Set<Integer> multiplyDevideSet = new HashSet<>();

    char previousChar = OPEN_PAREN_CHAR;
    for (int i = 0; i < len; i++) {
      char currentChar = inputExpression.charAt(i);
      if (currentChar == OPEN_PAREN_CHAR) {
        if (!BEFORE_OPEN_BRACKET_ACCEPT.contains(previousChar)) {
          throwUnexpectedChar(currentChar, i + 1);
        }
        parenStack.push(i);
        belongToParenPos[i] = parenStack.peek();
      } else if (currentChar == CLOSE_PAREN_CHAR) {
        if (parenStack.isEmpty() || BEFORE_CLOSE_BRACKET_NON_ACCEPT.contains(previousChar)) {
          throwUnexpectedChar(currentChar, i + 1);
        }
        belongToParenPos[i] = parenStack.peek();
        parenStack.pop();
      } else if (currentChar == PLUS_CHAR) {
        if (BEFORE_PLUS_MULTIPLE_DIVIDE_NON_ACCEPT.contains(previousChar)) {
          throwUnexpectedChar(currentChar, i + 1);
        }
        if (!parenStack.isEmpty()) {
          belongToParenPos[i] = parenStack.peek();
          plusMinusSet.add(parenStack.peek());
        }
      } else if (currentChar == MINUS_CHAR) {
        if (CHECK_MINUS_AS_OPERAND.contains(previousChar)) {
          if (i + 1 < len && OP_PARENTHESES_SPACE_SET.contains(inputExpression.charAt(i + 1))) {
            throwUnexpectedChar(currentChar, i + 1);
          }
        } else {
          if (!parenStack.isEmpty()) {
            belongToParenPos[i] = parenStack.peek();
            plusMinusSet.add(parenStack.peek());
          }
        }

      } else if (currentChar == MULTIPLY_CHAR || currentChar == DIVIDE_CHAR) {
        if (BEFORE_PLUS_MULTIPLE_DIVIDE_NON_ACCEPT.contains(previousChar)) {
          throwUnexpectedChar(currentChar, i + 1);
        }
        if (!parenStack.isEmpty()) {
          belongToParenPos[i] = parenStack.peek();
          multiplyDevideSet.add(parenStack.peek());
        }
      } else {
        // common chars cannot follow a closing parenthesis, except for a space ' '
        if (currentChar != SPACE_CHAR) {
          if (previousChar == CLOSE_PAREN_CHAR) {
            throwUnexpectedChar(currentChar, i + 1);
          }
          // avoid spaces between continuous chars; ex:1 1+2
          if (!OP_PARENTHESES_SET.contains(previousChar) && i > 0
              && inputExpression.charAt(i - 1) == SPACE_CHAR) {
            throwUnexpectedChar(currentChar, i + 1);
          }
        }
        if (!parenStack.isEmpty()) {
          belongToParenPos[i] = parenStack.peek();
        }
      }
      if (currentChar != SPACE_CHAR) {
        previousChar = currentChar;
      }
    }
    if (!parenStack.isEmpty()) {
      throw new IllegalArgumentException("Found unexpected character: too much OPEN_PAREN_CHAR");
    }
    if (OP_SET.contains(previousChar)) {
      throw new IllegalArgumentException(
          String.format("Found unexpected character '%s' in the last position, except for spaces",
              previousChar));
    }

    for (int i = 0; i < len; i++) {
      if (inputExpression.charAt(i) != MULTIPLY_CHAR && inputExpression.charAt(i) != DIVIDE_CHAR
          && inputExpression.charAt(i) != MINUS_CHAR) {
        continue;
      }
      int nextCharPos = i + 1;
      if (inputExpression.charAt(i) == MINUS_CHAR) {
        while (nextCharPos < len && (inputExpression.charAt(nextCharPos) == OPEN_PAREN_CHAR)
            || inputExpression.charAt(nextCharPos) == SPACE_CHAR) {
          if (inputExpression.charAt(nextCharPos) != SPACE_CHAR && plusMinusSet.contains(
              belongToParenPos[nextCharPos])) {
            remaindedParensSet.add(nextCharPos);
            break;
          }
          nextCharPos++;
        }
        continue;
      }
      nextCharPos = i + 1;
      while (nextCharPos < len && (inputExpression.charAt(nextCharPos) == OPEN_PAREN_CHAR
          || inputExpression.charAt(nextCharPos) == SPACE_CHAR)) {
        if (inputExpression.charAt(nextCharPos) != SPACE_CHAR && plusMinusSet.contains(
            belongToParenPos[nextCharPos])) {
          remaindedParensSet.add(nextCharPos);
          break;
        }
        nextCharPos++;
      }
      if (inputExpression.charAt(i) == DIVIDE_CHAR) {
        nextCharPos = i + 1;
        while (nextCharPos < len && (inputExpression.charAt(nextCharPos) == OPEN_PAREN_CHAR
            || inputExpression.charAt(nextCharPos) == SPACE_CHAR)) {
          if (inputExpression.charAt(nextCharPos) != SPACE_CHAR && multiplyDevideSet.contains(
              belongToParenPos[nextCharPos])) {
            remaindedParensSet.add(nextCharPos);
            break;
          }
          nextCharPos++;
        }
      }

      nextCharPos = i - 1;
      while (nextCharPos >= 0 && (inputExpression.charAt(nextCharPos) == CLOSE_PAREN_CHAR
          || inputExpression.charAt(nextCharPos) == SPACE_CHAR)) {
        if (inputExpression.charAt(nextCharPos) != SPACE_CHAR && plusMinusSet.contains(
            belongToParenPos[nextCharPos])) {
          remaindedParensSet.add(belongToParenPos[nextCharPos]);
          break;
        }
        nextCharPos--;
      }
    }

    StringBuilder expressionBuilder = new StringBuilder();
    for (int i = 0; i < len; i++) {
      if (inputExpression.charAt(i) != CLOSE_PAREN_CHAR
          && inputExpression.charAt(i) != OPEN_PAREN_CHAR) {
        expressionBuilder.append(inputExpression.charAt(i));
      } else {
        if (remaindedParensSet.contains(belongToParenPos[i])) {
          expressionBuilder.append(inputExpression.charAt(i));
        }
      }
    }

    return expressionBuilder.toString();
  }

  private static void throwUnexpectedChar(char currentChar, int i) {
    throw new IllegalArgumentException(
        String.format("Found unexpected character '%s' at position %s", currentChar, i));
  }

  public static void main(String[] args) {
    while (true) {
      System.out.println("******************************");
      System.out.println(
          "Please input a valid mathematical expression or type 'exit' to exit the program:");
      Scanner s = new Scanner(System.in);
      String expression = s.nextLine();
      if ("exit".equalsIgnoreCase(expression)) {
        break;
      }
      try {
        System.out.println(
            "Remove unnecessary parentheses: " + removeUnnecessaryParentheses((expression)));
      } catch (IllegalArgumentException e) {
        System.out.println("Invalid mathematical expression; caused by: " + e.getMessage());
      }
    }
  }
}
