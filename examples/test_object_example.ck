@import "../src/test.ck";

// TODO: Overload SinOsc == operator to compare objects

public class ObjectTestSuite {
  fun ObjectTestSuite() {
    // Create a test suite with a name
    Test.createSuite("ObjectTestSuite"); 

    // Call your test functions here
    GainObjectTest();
    SineObjectTest();

    // Print summary of all tests
    Test.summary(); 
  }

  fun void GainObjectTest() {
    Test test("GainObjectTest"); // Create a new test 
    Gain g => blackhole;
    g @=> Gain g_copy; // Copy reference to Gain object

    // Object assertion defaults to reference equality
    test.assert(g_copy, g); // Assert that g and g_copy are the same object
  }

  fun void SineObjectTest() {
    Test test("SineObjectTest"); // Create a new test 
    SinOsc osc1 => blackhole;
    SinOsc osc2 => blackhole;

    // Object assertion with SinOsc == overloading
    test.assert(osc1, osc2); // Assert that osc1 and osc2 are equal
  }
}

// RUN TESTS
MyTestSuite testSuite;
