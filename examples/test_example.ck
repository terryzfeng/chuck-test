@import "../src/test.ck";

public class MyTestSuite {
  fun MyTestSuite() {
    // Create a test suite with a name
    Test.createSuite("MyTestSuite"); 

    // Call your test functions here
    MyFirstTest();
    ASineTest();
    AFailingArrayTest();

    // Print summary of all tests
    Test.summary(); 
  }

  fun void MyFirstTest() {
    Test test("MyFirstTest"); // Create a new test 
    1 => int a;
    2 => int b;

    test.assert(a, 1); // Assert a is 1 otherwise abort
    test.assert(b, 2);  // Assert b is 2 otherwise abort
    test.expect(a + b, 3); // Expect a + b to be 3
  }

  fun void ASineTest() {
    Test test("ASineTest"); // Suite name is optional if set once before
    SinOsc osc => Gain g => dac;
    440 => osc.freq;
    0.5 => g.gain;

    1::second => now;
    test.assert(osc.freq(), 440); // Assert frequency is 440
    test.assert(g.gain(), 0.5); // Assert gain is 0.5
    test.expectTrue(dac.last() != 0.0); // Expect dac last sample to be non-zero
  }

  fun void AFailingArrayTest() {
    Test test("AFailingArrayTest");
    5 => int size; // Size of the array
    [1, 2, 3, 4, 5] @=> int expected[]; // Expected array
    int actual[size];

    // Fill actual array with values
    for (0 => int i; i < size; ++i) {
      i => actual[i];
      // i + 1 => actual[i]; // Uncomment this line instead to pass
    }

    test.expect(actual, expected); // Expect actual array to match expected
  }
}

// RUN TESTS
MyTestSuite testSuite;
