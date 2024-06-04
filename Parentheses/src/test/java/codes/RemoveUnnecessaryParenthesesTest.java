package codes;

import static funny.codes.RemoveUnnecessaryParentheses.removeUnnecessaryParentheses;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;

class RemoveUnnecessaryParenthesesTest {

  @ParameterizedTest
  @CsvFileSource(resources = "/data.csv", numLinesToSkip = 1)
  void testRemoveUnnecessaryParentheses(
      String input, String expected) {
    assertThat(removeUnnecessaryParentheses(input)).isEqualTo(expected);
  }

  @ParameterizedTest
  @CsvFileSource(resources = "/invalid_data.csv", numLinesToSkip = 1)
  void testRemoveUnnecessaryParenthesesInvalidData(
      String input) {
    assertThrows(IllegalArgumentException.class, () -> removeUnnecessaryParentheses(input));
    assertThatThrownBy(() -> removeUnnecessaryParentheses(input))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessageContaining("Found unexpected character");
  }
}