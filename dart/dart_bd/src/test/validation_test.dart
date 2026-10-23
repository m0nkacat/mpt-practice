import 'package:test/test.dart';
import 'package:dart_bd/dart_bd.dart';

void main() {
  group('isNotEmptyString', () {
    test('returns true for non-empty string', () {
      expect(isNotEmptyString('abc'), true);
      expect(isNotEmptyString('  a  '), true);
    });
    test('returns false for empty or null', () {
      expect(isNotEmptyString(''), false);
      expect(isNotEmptyString('   '), false);
      expect(isNotEmptyString(null), false);
    });
  });

  group('isPositiveNumber', () {
    test('returns true for positive int or double', () {
      expect(isPositiveNumber(5), true);
      expect(isPositiveNumber(0.1), true);
    });
    test('returns false for zero, negative, or non-number', () {
      expect(isPositiveNumber(0), false);
      expect(isPositiveNumber(-3), false);
      expect(isPositiveNumber('abc'), false);
      expect(isPositiveNumber(null), false);
    });
  });
}