import 'package:flutter/material.dart';

class Utils {
  static double calculateHeight(Object bc, double factor,
      [double subtract = 0.0]) {
    if (bc is BuildContext) {
      return _calculateSomething(
          MediaQuery.of(bc).size.height, factor, subtract);
    }
    if (bc is BoxConstraints) {
      return _calculateSomething(bc.maxHeight, factor, subtract);
    }
    return 0.0;
  }

  static double calculateWidth(Object bc, double factor,
      [double subtract = 0.0]) {
    if (bc is BuildContext) {
      return _calculateSomething(
          MediaQuery.of(bc).size.width, factor, subtract);
    }
    if (bc is BoxConstraints) {
      return _calculateSomething(bc.maxWidth, factor, subtract);
    }
    return 0.0;
  }

  static double _calculateSomething(double size, double factor,
      [double subtract = 0.0]) {
    return (size * factor) - subtract;
  }
}
