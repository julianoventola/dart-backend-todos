import 'dart:convert';
import 'dart:io';

class FileHandler {
  String path;

  FileHandler({this.path});

  Future<void> _validateFile() async {
    if (!await File(path).exists()) {
      await File(path).writeAsString('[]');
    }
  }

  dynamic getFile() async {
    await _validateFile();
    return json.decode(File('./todos.json').readAsStringSync());
  }
}
