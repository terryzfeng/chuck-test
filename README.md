# ChucK Test

A testing libary and framework for ChucK. Contains assert() and expect() functions.

## Get Started

First install the `Test` package with ChucK package manager `chump`.

```
chump <command here>
```

Create a test file for unit testing.

```java
@import "CKTest.ck"

public class MyTestSuite {
  fun MyTestSuite() {
    // Create a test suite with a name
    CKTest.createSuite("MyTestSuite");

    // Call your test functions here
    MyFirstTest();

    // Print test suite summary
    CKTest.summary();
  }

  fun void MyFirstTest() {
    CKTest test("MyFirstTest"); // Create a new test
    1 => int a;
    2 => int b;

    test.assert(a, 1); // Assert a is 1 otherwise abort
    test.assert(b, 2);  // Assert b is 2 otherwise abort
    test.expect(a + b, 3); // Expect a + b to be 3
  }
}

// RUN TESTS
MyTestSuite testSuite;
```

## Examples

See [`src/examples/`](./src/examples/) for some test examples.

## Documentation

`CKTest` library and framework full documentation:
[here](https://ccrma.stanford.edu/~tzfeng/projects/chuck-test/docs/test.html#Test)
