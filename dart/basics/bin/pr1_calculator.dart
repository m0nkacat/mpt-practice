import "dart:io";
import "dart:math";

void main() {
  print("Это калькулятор!!!!!!");
  print("Выберити операцию");
  print("1. + Сложение");
  print("2. - Вычитание");
  print("3. * Умножение");
  print("4. / Деление");
  print("5. ~/ Целочисленное деление");
  print("6. % Остаток от деления");
  print("7. Возведение в степень");
  print("8. == Равно");
  print("9. != Не равно");
  print("10. > Больше");
  print("11. < Меньше");
  print("12. >= Больше или равно");
  print("13. <= Меньше или равно");
  print("14. && Логическое И");
  print("15. || Логическое ИЛИ");
  print("16. ! Логическое НЕ");
  print("Введите номер(цифру или число) операции: ");
  int chose = int.parse(stdin.readLineSync()!);
  switch(chose) {
    case 1:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 + num2}"); 
        break;
    case 2:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 - num2}"); 
        break;
    case 3:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 * num2}"); 
        break;
    case 4:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 / num2}"); 
        break;
    case 5:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 ~/ num2}"); 
        break;
    case 6:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 % num2}"); 
        break;
    case 7:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${pow(num1, num2)}"); 
        break;
    case 8:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 == num2}"); 
        break;
    case 9:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 != num2}"); 
        break;
    case 10:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 > num2}"); 
        break;
    case 11:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 < num2}"); 
        break;
    case 12:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 >= num2}"); 
        break;
    case 13:
        print("Введите 2 числа: ");
        int num1 = int.parse(stdin.readLineSync()!);
        int num2 = int.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 <= num2}"); 
        break;
    case 14:
        print("Введите 2 булевых значения!!!!! (true/false): ");
        bool num1 = bool.parse(stdin.readLineSync()!);
        bool num2 = bool.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 && num2}"); 
        break;
    case 15:
        print("Введите 2 булевых значения!!!!! (true/false): ");
        bool num1 = bool.parse(stdin.readLineSync()!);
        bool num2 = bool.parse(stdin.readLineSync()!);
        print("Вот результат: ${num1 || num2}"); 
        break;
    case 16:
        print("Введите 1 булевое значения!!!!! (true/false): ");
        bool num1 = bool.parse(stdin.readLineSync()!);
        print("Вот результат: ${!num1}"); 
        break;
    default:
        print("Уважаемый пользователь, нет такого оператора!");
        break;
    }
}