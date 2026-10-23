import 'dart:io';
import '../domain/validators/string_validator.dart';
import '../domain/validators/number_validator.dart';

class InputHelper {
  static String askString(String prompt) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim() ?? '';
      if (isNotEmptyString(input)) return input;
      print('Ошибка: поле не может быть пустым');
    }
  }

  static int askPositiveInt(String prompt) {
    while (true) {
      stdout.write('$prompt (целое >0): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      final value = int.tryParse(input);
      if (value != null && isPositiveNumber(value)) return value;
      print('Ошибка: введите целое число больше 0');
    }
  }

  static DateTime askDate(String prompt) {
    while (true) {
      stdout.write('$prompt (ГГГГ-ММ-ДД): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      final date = DateTime.tryParse(input);
      if (date != null) return date;
      print('Ошибка: неверный формат даты (нужно ГГГГ-ММ-ДД)');
    }
  }
}