import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  // 1. Кружка и человек
  Mug mug = Mug(100);
  People person = People();
  print("До: ${mug.quantity}");
  person.Drink(mug);
  print("После: ${mug.quantity}");

  // 2. Шкаф
  Closet closet = Closet(["рубашка", "джинсы"]);
  print("Начальные вещи: ${closet.items}");
  closet.Put("кепка");
  print("После добавления: ${closet.items}");
  closet.Take("джинсы");
  print("После удаления: ${closet.items}");

  // 3. Гриф и блины
  Vulture vulture = Vulture(20);
  Plate p1 = Plate(10);
  Plate p2 = Plate(8);
  Plate p3 = Plate(5);
  vulture.addLeft(p1);
  vulture.addLeft(p2);
  vulture.addLeft(p3);
  vulture.addRight(p3);
  vulture.removeLeft(p1);
  vulture.removeRight(p3);

  // 4. Конвертация валют
  Convert money = Convert(100, "Euro");
  print("${money.value} ${money.currency}");
  money.To_dollars();
  print("${money.value} ${money.currency}");
  money.To_ruble();
  print("${money.value} ${money.currency}");
  money.To_euro();
  print("${money.value} ${money.currency}");

  // 5. Гараж (дженерик)
  Garage<String> garage = Garage<String>();
  garage.Put("Мазда");
  garage.Put("Тойота");
  print("В гараже: ${garage.items}");
  garage.Take("Мазда");
  print("После изъятия: ${garage.items}");

  // 6. Класс с перегруженными операциями
  Revers a = Revers(10);
  Revers b = Revers(4);
  print("a + b = ${(a + b).value}");
  print("a - b = ${(a - b).value}");
  print("a * b = ${(a * b).value}");
  print("a / b = ${(a / b).value}");

  // 7. Автомобиль (enum состояний)
  Car car = Car("BMW", "красный");
  print("Модель: ${car.model}, цвет: ${car.color}, состояние: ${car.state}");
  car.drive();
  car.turn();
  car.stop();

  // 8. Геометрические фигуры
  Rectangle rect = Rectangle(4, 5);
  Triangle tri = Triangle(3, 4, 5);
  print("Площадь прямоугольника: ${rect.area()}");
  print("Периметр треугольника: ${tri.perimeter()}");

  // 9. Перевод систем счисления
  print("255 в 16-й: ${NumberConverter.fromDec(255, 16)}");
  print("FF в 10-ю: ${NumberConverter.toDec("FF", 16)}");
  print("255 в 8-й: ${NumberConverter.fromDec(255, 8)}");
  print("377 в 10-ю: ${NumberConverter.toDec("377", 8)}");

  // 10. Список фигур с поиском максимальной площади
  ShapeList shapeList = ShapeList();
  shapeList.add(Rectangle(2, 3));
  shapeList.add(Rectangle(4, 5));
  shapeList.add(Triangle(6, 8, 10));
  Shape maxShape = shapeList.maxArea();
  print("Максимальная площадь: ${maxShape.area()}");

  // 11. Стол и столовые приборы
  Table table = Table();
  table.put(Fork());
  table.put(Spoon());
  table.put(Knife());
  List<String> names = [];
  for (var c in table.items) {
    names.add(c.name);
  }
  print("На столе: $names");
  table.remove(Spoon());
  names = [];
  for (var c in table.items) {
    names.add(c.name);
  }
  print("После удаления: $names");
}

class Mug {
  int quantity;
  Mug(this.quantity);
}

class People {
  void Drink(Mug a) {
    a.quantity = -1;
  }
}

class Closet {
  List<String> items;
  Closet(this.items);
  void Put(String a) {
    items.add(a);
  }

  void Take(String a) {
    items.remove(a);
  }
}

class Plate {
  int weight;
  Plate(this.weight);
}

class Vulture {
  final int maxWeight;
  int leftWeight = 0;
  int rightWeight = 0;

  Vulture(this.maxWeight);

  void addLeft(Plate plate) {
    if (leftWeight + plate.weight > maxWeight) {
      print("Нельзя добавить блин весом ${plate.weight}: левая сторона перегружена");
      return;
    }
    leftWeight += plate.weight;
    print("Добавлен блин на левую сторону. Текущий вес слева: $leftWeight");
  }

  void addRight(Plate plate) {
    if (rightWeight + plate.weight > maxWeight) {
      print("Нельзя добавить блин весом ${plate.weight}: правая сторона перегружена");
      return;
    }
    rightWeight += plate.weight;
    print("Добавлен блин на правую сторону. Текущий вес справа: $rightWeight");
  }

  void removeLeft(Plate plate) {
    if (leftWeight - plate.weight < 0) {
      print("Нельзя снять блин: на левой стороне нет такого веса");
      return;
    }
    leftWeight -= plate.weight;
    print("Снят блин с левой стороны. Текущий вес слева: $leftWeight");
  }

  void removeRight(Plate plate) {
    if (rightWeight - plate.weight < 0) {
      print("Нельзя снять блин: на правой стороне нет такого веса");
      return;
    }
    rightWeight -= plate.weight;
    print("Снят блин с правой стороны. Текущий вес справа: $rightWeight");
  }
}

class Convert {
  double value;
  String currency;
  Convert(this.value, this.currency);

  void To_dollars() {
    if (currency == "Dollar") {
      return;
    } else {
      switch (currency) {
        case "Euro":
          value = value * 0.85;
          currency = "Dollar";
          break;
        case "Ruble":
          value = value * 0.013;
          currency = "Dollar";
          break;
      }
    }
  }

  void To_euro() {
    if (currency == "Euro") {
      return;
    } else {
      if (currency == "Dollar") {
      } else if (currency == "Ruble") {
        value = value * 0.013;
        currency = "Dollar";
      }
      if (currency == "Dollar") {
        value = value / 0.85;
        currency = "Euro";
      }
    }
  }

  void To_ruble() {
    if (currency == "Ruble") {
      return;
    } else {
      if (currency == "Dollar") {
        return;
      } else if (currency == "Euro") {
        value = value * 0.85;
        currency = "Dollar";
      }
      if (currency == "Dollar") {
        value = value / 0.013;
        currency = "Ruble";
      }
    }
  }
}

class Garage<T> {
  List<T> items = [];
  void Put(T item) {
    items.add(item);
  }

  bool Take(T item) {
    return items.remove(item);
  }
}

class Revers {
  final double value;
  Revers(this.value);

  Revers operator +(Revers other) {
    return Revers(value - other.value);
  }

  Revers operator -(Revers other) {
    return Revers(value + other.value);
  }

  Revers operator *(Revers other) {
    return Revers(value / other.value);
  }

  Revers operator /(Revers other) {
    return Revers(value * other.value);
  }
}

enum State { stop, drive, turn }

class Car {
  String model;
  String color;
  State state;
  Car(this.model, this.color) : state = State.stop;

  void stop() {
    state = State.stop;
    print("Автомобиль остановлен.");
  }

  void drive() {
    state = State.drive;
    print("Автомобиль едет.");
  }

  void turn() {
    state = State.turn;
    print("Автомобиль поворачивает.");
  }
}

abstract class Shape {
  double area();
  double perimeter();
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double area() {
    return width * height;
  }

  @override
  double perimeter() {
    return 2 * (width + height);
  }
}

class Triangle extends Shape {
  double a, b, c;

  Triangle(this.a, this.b, this.c);

  @override
  double area() {
    double s = (a + b + c) / 2;
    return sqrt(s * (s - a) * (s - b) * (s - c));
  }

  @override
  double perimeter() {
    return a + b + c;
  }
}

class NumberConverter {
  static String fromDec(int number, int base) {
    if (base == 16) {
      return number.toRadixString(16).toUpperCase();
    }
    if (base == 8) {
      return number.toRadixString(8);
    }
    return number.toString();
  }

  static int toDec(String number, int base) {
    return int.parse(number, radix: base);
  }
}

class ShapeList {
  List<Shape> shapes = [];
  void add(Shape s) {
    shapes.add(s);
  }

  Shape maxArea() {
    Shape maxShape = shapes[0];
    for (int i = 1; i < shapes.length; i++) {
      if (shapes[i].area() > maxShape.area()) {
        maxShape = shapes[i];
      }
    }
    return maxShape;
  }
}

abstract class Cutlery {
  String name;
  Cutlery(this.name);
}

class Fork extends Cutlery {
  Fork() : super("Вилка");
}

class Spoon extends Cutlery {
  Spoon() : super("Ложка");
}

class Knife extends Cutlery {
  Knife() : super("Нож");
}

class Table {
  List<Cutlery> items = [];
  void put(Cutlery c) {
    items.add(c);
  }
  void remove(Cutlery c) {
    items.remove(c);
  }
}