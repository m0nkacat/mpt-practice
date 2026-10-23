import 'dart:typed_data';
import 'dart:convert';
import 'enums.dart';

abstract class Identifiable {
  int getId();
}

class Question implements Identifiable {
  int id;
  String title;
  String body;
  String author;
  int views;
  bool pinned;
  Category category;
  Status status;
  String? bestAnswer;
  DateTime createdAt;

  Question({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    this.views = 0,
    this.pinned = false,
    required this.category,
    this.status = Status.open,
    this.bestAnswer,
    required this.createdAt,
  });

  @override
  int getId() => id;

  @override
  bool operator ==(Object other) => other is Question && other.id == id;

  @override
  int get hashCode => id.hashCode;

  Uint8List toBytes() {
    final b = BytesBuilder();

    void writeInt(int v) {
      final d = ByteData(4);
      d.setInt32(0, v, Endian.big);
      b.add(d.buffer.asUint8List());
    }

    void writeStr(String s) {
      final e = utf8.encode(s);
      writeInt(e.length);
      b.add(e);
    }

    writeInt(id);
    writeStr(title);
    writeStr(body);
    writeStr(author);
    writeInt(views);
    b.addByte(pinned ? 1 : 0);
    b.addByte(category.index);
    b.addByte(status.index);

    if (bestAnswer == null) {
      b.addByte(0);
    } else {
      b.addByte(1);
      writeStr(bestAnswer!);
    }

    final d = ByteData(8);
    d.setFloat64(0, createdAt.millisecondsSinceEpoch.toDouble(), Endian.big);
    b.add(d.buffer.asUint8List());

    return b.toBytes();
  }

  factory Question.fromBytes(Uint8List bytes) {
    int pos = 0;

    int readInt() {
      final v = ByteData.sublistView(bytes, pos, pos + 4).getInt32(0, Endian.big);
      pos += 4;
      return v;
    }

    String readStr() {
      final len = readInt();
      final s = utf8.decode(bytes.sublist(pos, pos + len));
      pos += len;
      return s;
    }

    final id = readInt();
    final title = readStr();
    final body = readStr();
    final author = readStr();
    final views = readInt();
    final pinned = bytes[pos++] == 1;
    final category = Category.values[bytes[pos++]];
    final status = Status.values[bytes[pos++]];

    String? bestAnswer;
    if (bytes[pos++] == 1) bestAnswer = readStr();

    final ms = ByteData.sublistView(bytes, pos, pos + 8).getFloat64(0, Endian.big).toInt();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(ms);

    return Question(
      id: id,
      title: title,
      body: body,
      author: author,
      views: views,
      pinned: pinned,
      category: category,
      status: status,
      bestAnswer: bestAnswer,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'author': author,
        'views': views,
        'pinned': pinned,
        'category': category.index,
        'status': status.index,
        'bestAnswer': bestAnswer,
        'createdAt': createdAt.toIso8601String(),
      };
}
