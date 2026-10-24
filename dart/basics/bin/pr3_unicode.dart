import 'dart:io';
import 'dart:math';
import 'package:characters/characters.dart';

void main() {
  

  Random random = Random();

  print('Введите ваше имя:');
  String name = stdin.readLineSync() ?? '';

  print('Генерируем случайное настроение...');

  int mood = random.nextInt(3);

  String emoji = '';
  String text = '';
  int energy = 0;

  switch (mood) {
    case 0:
      emoji = '\u{1F60A}';
      text = 'счастливое';
      energy = 8;
      break;
    case 1:
      emoji = '\u{1F622}';
      text = 'грустное';
      energy = 3;
      break;
    case 2:
      emoji = '\u{1F60E}';
      text = 'взволнованный';
      energy = 9;
      break;
  }

  print(
    'Привет, ' +
        name +
        '! Твое настроение: ' +
        emoji +
        ' ' +
        text +
        ' (энергия: ' +
        energy.toString() +
        '/10)',
  );

  int code = emoji.runes.first;
  print('');
  print('Юникод вашего эмодзи: U+' + code.toRadixString(16).toUpperCase());

  print('Хотите просмотреть сложные эмодзи? (да/нет):');
  String ans = stdin.readLineSync() ?? '';

  if (ans == "yes") {
    print('Введите комбинацию эмодзи:');
    String s = stdin.readLineSync() ?? '';

    print('Анализ строки "' + s + '":');

    print('- 16-битных единиц: ' + s.length.toString());
    print('- Кодовых точек: ' + s.runes.length.toString());
    print('- Реальных символов: ' + s.characters.length.toString());

    print('Подробный вывод юникода:');

    int i = 1;
    for (int r in s.runes) {
      print(
        'Символ ' + i.toString() + ': → U+' + r.toRadixString(16).toUpperCase(),
      );
      i++;
    }
  } else {
    return;
  }
  print('Спасибо, приходите снова!');
}
