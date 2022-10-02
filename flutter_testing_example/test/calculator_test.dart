import 'package:flutter_test/flutter_test.dart';

import 'calculator.dart';

void main() {
  // Run before all the test
  // setUpAll(body)
  // Run before every test
  // setUp(body)
  // Run after every test
  // tearDown(body)
  // Run after all test
  // tearDownAll(body)

  Calculator? calc;
  setUpAll(() {
    calc = Calculator();
  });
  tearDownAll(() {
    print("We are done");
  });
  group("i want to test my calculator", () {
    test('addition', () {
      // Step 1
      // Calculator cal = Calculator();
      // Step 2
      int result = calc!.add(5, 6);
      // Step 3

      expect(result, 11);
      expect(result, isNot(10));
    });
    test('multiplication', () {
      // Step 1
      // Calculator cal = Calculator();
      // Step 2
      int result = calc!.mul(3, 2);
      // Step 3

      expect(result, 6);
      expect(result, isNot(9));
    });
  });
}
