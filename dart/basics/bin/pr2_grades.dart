import 'dart:io';

void main() {
  List<String> students = [
    'Иванов Иван',
    'Петров Петр',
    'Сидоров Алексей',
    'Кузнецова Мария',
    'Смирнова Анна',
    'Васильев Дмитрий',
  ];

  List<String> subjects = ['ОАИП', 'ПТПМ', 'РМП', 'ЭВМ'];

  Map<String, Map<String, int>> grades = {
    'Иванов Иван': {'ОАИП': 5, 'ПТПМ': 4, 'РМП': 5, 'ЭВМ': 4},
    'Петров Петр': {'ОАИП': 3, 'ПТПМ': 2, 'РМП': 4, 'ЭВМ': 4},
    'Сидоров Алексей': {'ОАИП': 4, 'ПТПМ': 5, 'РМП': 5, 'ЭВМ': 2},
    'Кузнецова Мария': {'ОАИП': 2, 'ПТПМ': 5, 'РМП': 4, 'ЭВМ': 5},
    'Смирнова Анна': {'ОАИП': 4, 'ПТПМ': 4, 'РМП': 3, 'ЭВМ': 4},
    'Васильев Дмитрий': {'ОАИП': 3, 'ПТПМ': 3, 'РМП': 3, 'ЭВМ': 3},
  };

  bool run = true;

  while (run) {
    print("Выберите действие");
    print("0. Выход");
    print("1. Разделить студентов по среднему баллу");
    print("2. Подсчитать оценки");
    print("3. Студенты с 5 по предметам");
    print("4. Предметы без двоек");
    print("5. Предмет с наибольшим количеством двоек");
    print("6. Студенты с наибольшим количеством пятёрок");
    print("7. Предметы ниже 4 у студентов");
    print("8. Пары студент-предмет где стоит 5");

    int chose = int.parse(stdin.readLineSync()!);

    switch (chose) {
      case 0:
        run = false;
        print("пока");
        break;

      case 1:
        z1(grades);
        break;

      case 2:
        z2(grades);
        break;

      case 3:
        z3(grades, subjects);
        break;

      case 4:
        z4(grades, subjects);
        break;

      case 5:
        z5(grades, subjects);
        break;

      case 6:
        z6(grades);
        break;

      case 7:
        z7(grades);
        break;

      case 8:
        z8(grades);
        break;
    }
  }
}

void z1(Map<String, Map<String, int>> grades) {
  List<String> otl = [];
  List<String> hor = [];
  List<String> other = [];

  for (String student in grades.keys) {
    int sum = 0;
    int count = 0;

    for (int g in grades[student]!.values) {
      sum = sum + g;
      count = count + 1;
    }

    double avg = sum / count;

    if (avg >= 4.5) {
      otl.add(student);
    } else {
      if (avg >= 3.5) {
        hor.add(student);
      } else {
        other.add(student);
      }
    }
  }

  print("Отличники:");
  for (int i = 0; i < otl.length; i++) {
    print(otl[i]);
  }

  print("Хорошисты:");
  for (int i = 0; i < hor.length; i++) {
    print(hor[i]);
  }

  print("Остальные:");
  for (int i = 0; i < other.length; i++) {
    print(other[i]);
  }
}

void z2(Map<String, Map<String, int>> grades) {
  int two = 0;
  int three = 0;
  int four = 0;
  int five = 0;

  for (String student in grades.keys) {
    for (int g in grades[student]!.values) {
      if (g == 2) two = two + 1;
      if (g == 3) three = three + 1;
      if (g == 4) four = four + 1;
      if (g == 5) five = five + 1;
    }
  }

  print("2: $two");
  print("3: $three");
  print("4: $four");
  print("5: $five");
}

void z3(Map<String, Map<String, int>> grades, List<String> subjects) {
  for (int i = 0; i < subjects.length; i++) {
    String subject = subjects[i];

    print(subject);

    for (String student in grades.keys) {
      if (grades[student]![subject] == 5) {
        print(student);
      }
    }
  }
}

void z4(Map<String, Map<String, int>> grades, List<String> subjects) {
  for (int i = 0; i < subjects.length; i++) {
    String subject = subjects[i];

    bool hasTwo = false;

    for (String student in grades.keys) {
      if (grades[student]![subject] == 2) {
        hasTwo = true;
      }
    }

    if (hasTwo == false) {
      print(subject);
    }
  }
}

void z5(Map<String, Map<String, int>> grades, List<String> subjects) {
  int max = 0;
  String name = "";

  for (int i = 0; i < subjects.length; i++) {
    String subject = subjects[i];

    int count = 0;

    for (String student in grades.keys) {
      if (grades[student]![subject] == 2) {
        count = count + 1;
      }
    }
    if (count > max) {
      max = count;
      name = subject;
    }
  }

  print(name);
  print("двоек: $max");
}

void z6(Map<String, Map<String, int>> grades) {
  int max = 0;
  Map<String, int> counts = {};
  for (String student in grades.keys) {
    int c = 0;
    for (int g in grades[student]!.values) {
      if (g == 5) {
        c = c + 1;
      }
    }
    counts[student] = c;
    if (c > max) {
      max = c;
    }
  }
  for (String student in counts.keys) {
    if (counts[student] == max) {
      print(student);
      print("пятёрок: $max");
    }
  }
}

void z7(Map<String, Map<String, int>> grades) {
  for (String student in grades.keys) {
    int count = 0;
    String list = "";

    for (String subject in grades[student]!.keys) {
      if (grades[student]![subject]! < 4) {
        count = count + 1;
        list = list + subject + " ";
      }
    }

    print(student);
    print("предметов ниже 4: $count");
    print(list);
  }
}

void z8(Map<String, Map<String, int>> grades) {
  for (String student in grades.keys) {
    for (String subject in grades[student]!.keys) {
      if (grades[student]![subject] == 5) {
        print(student + " - " + subject);
      }
    }
  }
}
