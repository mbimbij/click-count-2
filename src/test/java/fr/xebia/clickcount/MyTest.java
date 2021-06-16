package fr.xebia.clickcount;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class MyTest {
  @Test
  void failingTest() {
    assertThat(true).isFalse();
  }


  @Test
  void passingTest() {
    assertThat(4).isEqualTo(2+2);
  }
}
