import 'dart:io';

mixin DirectoryRequest {
  // /// By default directory = Directory.current
  late final Directory directory;

  // DirectoryRequest([Directory? directory])
  //     : _directory = directory ?? Directory.current;

  File _file(String extra) => File('${directory.path}/$extra');

  Future<bool> isExist(String fileName) async {
    if (await directory.exists()) {
      return await _file(fileName).exists();
    }
    throw Exception('Directory Not Exists');
  }

  Future<String> getFile(String fileName) async {
    if (await isExist(fileName)) {
      return (await _file(fileName).readAsLines()).join('\n');
    }
    throw Exception('File Not Exists');
  }

  Future<void> setFile(String fileName, String data) =>
      _file(fileName).writeAsString(data);
}
