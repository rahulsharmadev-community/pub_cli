import 'dart:convert';
import 'dart:io';
import 'package:json2yaml/json2yaml.dart';
import 'package:yaml/yaml.dart';
import '../core_request/directory_request.dart';

class YamlRequestRepo with DirectoryRequest {
  final String filePath;
  static const format = '.yaml';
  YamlRequestRepo(String fileName) : filePath = '$fileName$format' {
    directory = Directory.current;
  }

  Future<bool> get isFileExistInCurrent async => isExist(filePath);

  Future<Map<String, dynamic>> get getJson async {
    var raw = await getFile(filePath);
    return raw.isEmpty
        ? {}
        : Map<String, dynamic>.from(jsonDecode(jsonEncode(loadYaml(raw))));
  }

  Future<void> setJson(Map<String, dynamic> map) async {
    var data = json2yaml(map, yamlStyle: YamlStyle.pubspecYaml);
    return await setFile(filePath, data);
  }
}
