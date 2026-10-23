import 'dart:io';
import 'dart:typed_data';
import 'question.dart';

Future<void> saveToFile(List<Question> list) async {
  final b = BytesBuilder();
  final cnt = ByteData(4);
  cnt.setInt32(0, list.length, Endian.big);
  b.add(cnt.buffer.asUint8List());

  for (final q in list) {
    final bytes = q.toBytes();
    final len = ByteData(4);
    len.setInt32(0, bytes.length, Endian.big);
    b.add(len.buffer.asUint8List());
    b.add(bytes);
  }

  await File('data.bin').writeAsBytes(b.toBytes());
}

Future<List<Question>> loadFromFile() async {
  final f = File('data.bin');
  if (!await f.exists()) {
    await File('data.bin').writeAsBytes(
      (ByteData(4)..setInt32(0, 0, Endian.big)).buffer.asUint8List(),
    );
    throw Exception('Файл data.bin не найден, создан новый');
  }

  final bytes = await f.readAsBytes();
  if (bytes.length < 4) return [];

  int pos = 0;

  int readInt() {
    final v = ByteData.sublistView(bytes, pos, pos + 4).getInt32(0, Endian.big);
    pos += 4;
    return v;
  }

  final count = readInt();
  final result = <Question>[];

  for (int i = 0; i < count; i++) {
    final len = readInt();
    final chunk = Uint8List.sublistView(bytes, pos, pos + len);
    pos += len;
    result.add(Question.fromBytes(chunk));
  }

  return result;
}

Future<void> copyFile(String src, String dst) async {
  final sink = File(dst).openWrite();
  await File(src).openRead().pipe(sink);
}
