// Test library
@doc "A testing libary and framework for ChucK. Contains assert() and expect() 
functions. <br>
<br>
Written by Terry Feng, 2025."
public class CKTest {
  "1.0.0" => static string version;

  // STATIC VARIABLES
  @doc "Test suite name."
  static string test_suite_name_;
  @doc "Tolerance for floating point comparisons. Default is 0.0001."
  0.0001 => static float float_tolerance_;
  @doc "(hidden) Number of tests in current suite."
  0 => static int num_tests_;
  @doc "(hidden) Number of tests passed in current suite."
  0 => static int num_passed_;
  @doc "(hidden) Number of tests failed in current suite."
  0 => static int num_failed_;

  // MEMBER VARIABLES
  @doc "(hidden) Current test state, 1 = passed, 0 = failed."
  int test_state_;
  @doc "Test name."
  string test_name_;

  // CONSTRUCTORS
  @doc "Constructor for Test class with default 'MyTest' name."
  fun CKTest() {
    CKTest("MyTest");
  }

  @doc "Constructor for Test class with test name."
  fun CKTest(string test_name) {
    test_name => test_name_;
    1 => test_state_;
    num_tests_++;
    cherr <= IO.newline();
    <<< "Running test:", test_name_ >>>;
  }

  // DESTRUCTORS
  @doc "(hidden) Destructor for Test class."
  fun @destruct() {
    if (test_state_) {
      <<< "[PASSED]:", test_name_ >>>;
      num_passed_++;
    } else {
      <<< "[FAILED]:", test_name_ >>>;
      num_failed_++;
    }
  }

  // STATIC FUNCTIONS
  @doc "Create a test suite with a name. Returns test suite name."
  fun static string createSuite(string test_suite_name) {
    <<< "Create test suite:", test_suite_name >>>;
    <<< "---", "" >>>;
    test_suite_name => test_suite_name_;
    return test_suite_name_;
  }

  @doc "Print a summary of the test suite (tests passed / total)."
  fun static void summary() {
    cherr <= IO.newline();
    <<< "---", "" >>>;
    if (test_suite_name_ == "") {
      <<< "Summary:", "" >>>;
    } else {
      <<< test_suite_name_, "Summary:" >>>;
    }
    <<< "Tests passed:", num_passed_, "/", num_tests_ >>>;
    if (num_failed_ > 0) {
      <<< num_failed_, "tests failed." >>>;
    } else {
      <<< "All tests passed.", "" >>>;
    }
  }

  @doc "(hidden) Reset the test suite pass/fail counters."
  fun static void reset() {
    0 => num_passed_;
    0 => num_failed_;
    0 => num_tests_;
  }

  @doc "Set the tolerance for floating point comparisons. Default is 0.0001."
  fun static void setTolerance(float tolerance) {
    tolerance => float_tolerance_;
  } 

  // MEMBER FUNCTIONS
  @doc "Expect two integers to be equal."
  fun void expect(int actual, int expected) {
    if (actual != expected) {
      <<< "ExpectError: Actual:", actual, "Expected:", expected >>>;
      0 => test_state_;
    }
  }

  @doc "Expect two floats to be equal or within float tolerance."
  fun void expect(float actual, float expected) {
    if (!(Math.fabs(actual - expected) < float_tolerance_)) {
      <<< "ExpectError: Actual:", actual, " Expected:", expected >>>;
      0 => test_state_;
    }
  }

  @doc "Expect two Objects to be equal. Will compare references by default. 
  Override the == operator for custom comparison."
  fun void expect(Object actual, Object expected) {
    if (actual == expected) {
      return;
    }
    <<< "ExpectError: Object", actual, "and", expected, "are not equal." >>>;
    0 => test_state_;
  }

  @doc "Expect two int arrays to be equal."
  fun void expect(int actual[], int expected[]) {
    (actual.size() == expected.size()) => int case;
    if (!case) {
      <<< "ExpectError: array size does not match." >>>;
      <<< "Actual:", actual.size(), "Expected:", expected.size() >>>;
      0 => test_state_;
      return;
    }
    for (0 => int i; i < actual.size(); ++i) {
      (actual[i] == expected[i]) => case;
      if (!case) {
        <<< "ExpectError at index", i, ": Actual:", actual[i],
             "Expected:", expected[i] >>>;
        0 => test_state_;
        return;
      }
    }
  }

  @doc "Expect two float arrays to be equal."
  fun void expect(float actual[], float expected[]) {
    (actual.size() == expected.size()) => int case;
    if (!case) {
      <<< "ExpectError: array size does not match.">>>;
      <<< "Actual:", actual.size(), "Expected:", expected.size() >>>;
      0 => test_state_;
      return;
    }
    for (0 => int i; i < actual.size(); ++i) {
      (Math.fabs(actual[i] - expected[i]) < float_tolerance_) => case;
      if (!case) {
        <<< "ExpectError at index", i, ": Actual:", actual[i], 
            "Expected:", expected[i] >>>;
        0 => test_state_;
        return;
      }
    }
  }

  @doc "Expect two strings to be equal."
  fun void expect(string actual, string expected) {
    (actual.length() == expected.length()) => int case;
    if (!case) {
      <<< "ExpectError: string length does not match.">>>;
      <<< "Actual:", actual.length(), "Expected:", expected.length() >>>;
      0 => test_state_;
      return;
    }
    for (0 => int i; i < actual.length(); ++i) {
      (actual.charAt(i) == expected.charAt(i)) => case;
      if (!case) {
        <<< "ExpectError: Actual:", actual, "Expected:", expected >>>;
        0 => test_state_;
        return;
      }
    }
  }

  @doc "Expect an expression to evaluate to non-zero (true)."
  fun void expectTrue(int actual) {
    if (actual == 0) {
      <<< "ExpectTrue:", actual, "is not true">>>;
      0 => test_state_;
    }
  }

  @doc "Expect an expression to evaluate to zero (false)."
  fun void expectFalse(int actual) {
    if (actual != 0) {
      <<< "ExpectFalse:", actual, "is not false">>>;
      0 => test_state_;
    }
  }

  @doc "Assert two integers to be equal."
  fun void assert(int actual, int expected) {
    if (actual != expected) {
      <<< "AssertError: Actual:", actual, "Expected:", expected >>>;
      0 => test_state_;
      abort();
    }
  }

  @doc "Expect two floats to be equal or within float tolerance."
  fun void assert(float actual, float expected) {
    if (!(Math.fabs(actual - expected) < float_tolerance_)) {
      <<< "AssertError: Actual:", actual, " Expected:", expected >>>;
      0 => test_state_;
      abort();
    }
  }

  @doc "Assert two Objects to be equal. Will compare references by default. 
  Override the == operator for custom comparison."
  fun void assert(Object actual, Object expected) {
    if (actual == expected) {
      return;
    }
    <<< "ExpectError: Object", actual, "and", expected, "are not equal." >>>;
    0 => test_state_;
    abort();
  }

  @doc "Assert an expression to be non-zero (true)."
  fun void assertTrue(int actual) {
    if (actual == 0) {
      <<< "AssertError:", actual, "is not true">>>;
      0 => test_state_;
      abort();
    } 
  }

  @doc "Assert an expression to be zero (false)."
  fun void assertFalse(int actual) {
    if (actual != 0) {
      <<< "AssertFalse:", actual, "is not false">>>;
      0 => test_state_;
      abort();
    }
  }

  @doc "(hidden) Abort test and halt execution if an assertion fails."
  fun void abort() {
    <<< "ABORTING:", test_name_, "due to failed assertion.">>>;
    me.exit();
  }
}
