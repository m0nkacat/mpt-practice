import 'dart:io';
import 'dart:isolate';

enum Action { start, add, delete, edit, search, list, stats, viewLogs, report, exit, error }

String _label(Action a) {
  switch (a) {
    case Action.start:    return 'START';
    case Action.add:      return 'ADD';
    case Action.delete:   return 'DELETE';
    case Action.edit:     return 'EDIT';
    case Action.search:   return 'SEARCH';
    case Action.list:     return 'LIST';
    case Action.stats:    return 'STATS';
    case Action.viewLogs: return 'VIEW_LOGS';
    case Action.report:   return 'REPORT';
    case Action.exit:     return 'EXIT';
    case Action.error:    return 'ERROR';
  }
}

void _logIsolate(SendPort sp) {
  final rp = ReceivePort();
  sp.send(rp.sendPort);
  rp.listen((msg) async {
    if (msg is String) {
      try {
        await File('logs.txt').writeAsString(msg, mode: FileMode.append);
      } catch (e) {
        print('[LOG ERROR] $e');
      }
    }
  });
}

SendPort? _port;
Isolate? _iso;

Future<void> initLogger() async {
  final rp = ReceivePort();
  _iso = await Isolate.spawn(_logIsolate, rp.sendPort);
  _port = await rp.first as SendPort;
}

void log(Action a, String msg) {
  final now = DateTime.now();
  final ts = '${now.year.toString().padLeft(4,'0')}-'
      '${now.month.toString().padLeft(2,'0')}-'
      '${now.day.toString().padLeft(2,'0')} '
      '${now.hour.toString().padLeft(2,'0')}:'
      '${now.minute.toString().padLeft(2,'0')}:'
      '${now.second.toString().padLeft(2,'0')}';
  _port?.send('[$ts] [${_label(a)}] $msg\n');
}

List<String> getLastLines(int n) {
  final f = File('logs.txt');
  if (!f.existsSync()) return [];
  final lines = f.readAsLinesSync();
  final from = lines.length > n ? lines.length - n : 0;
  return lines.sublist(from);
}

void stopLogger() {
  _iso?.kill(priority: Isolate.immediate);
}
