import 'dart:io';
import '/logic/core_request/directory_request.dart';
import '/model/pubspec_attribute.dart';

class CachedRepo with DirectoryRequest {
  static const _cachedFile = '__pubcli_cache_data.txt';
  CachedRepo() {
    directory = Directory.systemTemp;
  }

  Future<void> setPubspecData(Pubspec data) async =>
      setFile(_cachedFile, data.toJson());

  Future<Pubspec> get getPubspecData async {
    if (await isExist(_cachedFile)) {
      return Pubspec.fromJson(await getFile(_cachedFile));
    } else {
      return Pubspec.kdefault;
    }
  }
}
