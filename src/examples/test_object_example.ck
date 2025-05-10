@import "../CKTest.ck";

// TODO: Fix overloading for SinOsc == operator
// fun SinOsc @operator ==(SinOsc osc1, SinOsc osc2) {
//   return osc1.freq() == osc2.freq() && osc1.gain() == osc2.gain();
// }

public class ObjectTestSuite {
  fun ObjectTestSuite() {
    // Create a test suite with a name
    CKTest.createSuite("ObjectTestSuite");

    // Call your test functions here
    GainObjectTest();
    SineObjectTest();

    // Print summary of all tests
    CKTest.summary();
  }

  fun void GainObjectTest() {
    // Compare two Gain objects by reference
    CKTest test("GainObjectTest");
    Gain g => blackhole;
    g @=> Gain g_copy; // Copy reference to Gain object

    // Object comparison with reference equality
    test.expect(g_copy, g); // Assert that g and g_copy are the same object
  }

  fun void SineObjectTest() {
    // Compare two SinOsc objects by frequency and gain
    CKTest test("SineObjectTest");
    SinOsc osc1 => blackhole;
    SinOsc osc2 => blackhole;

    // Object comparison with frequency and gain
    test.expect(osc1, osc2); // Assert that osc1 and osc2 are equal
  }
}

// RUN TESTS
ObjectTestSuite testSuite;
