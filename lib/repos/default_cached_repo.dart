import 'dart:io';
import 'package:pub_cli/model/pubspec_attribute.dart';
import 'package:pub_cli/repos/directory_request.dart';

class DefaultCachedData with DirectoryRequest {
  static const _cachedFile = '__pubcli_cache_data.txt';
  DefaultCachedData() {
    directory = Directory.systemTemp;
  }

  Future<void> setPubspecData(Pubspec data) async {
    return setFile(_cachedFile, data.toJson());
  }

  Future<Pubspec> get getPubspecData async {
    if (await isExist(_cachedFile)) {
      return Pubspec.fromJson(await getFile(_cachedFile));
    } else {
      return Pubspec.kdefault;
    }
  }
}
