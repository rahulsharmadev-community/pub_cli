import 'package:pub_cli/model/pubspec_attribute.dart';
import '_extension.dart';
import 'package:pub_cli/logic/repos.dart';

class PubspaceYaml with PubDevHttpRequest {
  final YamlRequestRepo yamlRepo;
  final List<String> dependencies, devDependencies;
  PubspaceYaml(
      {this.dependencies = const [],
      this.devDependencies = const [],
      YamlRequestRepo? yamlRequestRepo})
      : yamlRepo = yamlRequestRepo ?? YamlRequestRepo('pubspec');

  static Future<Pubspec> get getCachedPubspec async =>
      CachedRepo().getPubspecData;
  static Future<void> editCachedPubspec(Pubspec data) async =>
      await CachedRepo().setPubspecData(data);

  Future<void> createOrEdit() async {
    late Map<String, dynamic> afterEdit;
    var cachedJson = await CachedRepo().getPubspecData;
    Map<String, dynamic>? ed, edd, eot;
    if (await yamlRepo.isFileExistInCurrent) {
      var existingJson = await yamlRepo.getJson;
      cachedJson = cachedJson.copyWith(
          name: existingJson['name'],
          description: existingJson['description'],
          version: existingJson['version'],
          homepage: existingJson['homepage'],
          documentation: existingJson['documentation'],
          environmentSDK: existingJson['environment'] != null
              ? Map.from(existingJson['environment'])['sdk']
              : null,
          dependencies: dependencies,
          devDependencies: devDependencies);
      ed = existingJson['dependencies'];
      edd = existingJson['dev_dependencies'];
      eot = existingJson['flutter'];
    }
    afterEdit = await convetToYamlJson(cachedJson, ed, edd, eot);
    await yamlRepo.setJson(afterEdit);
  }

  Future<Map<String, dynamic>> _addDepFromPubdev(List<String> dep) async {
    Map<String, dynamic> tempMap = {};
    await Future.wait(dep.map((e) async {
      tempMap.addAll(await getPackage(e));
    }).toList());
    return tempMap;
  }

  Future<Map<String, dynamic>> convetToYamlJson(Pubspec pubspec,
      [Map<String, dynamic>? dependencies,
      Map<String, dynamic>? devDependencies,
      Map<String, dynamic>? otherAttributes]) async {
    Map<String, dynamic> dep = dependencies ??
        {
          "flutter": {"sdk": "flutter"}
        };
    Map<String, dynamic> devDep = devDependencies ??
        {
          "flutter_test": {"sdk": "flutter"},
        };

    if (pubspec.dependencies.isNotEmpty) {
      dep + await _addDepFromPubdev(pubspec.dependencies);
    }
    if (pubspec.devDependencies.isNotEmpty) {
      devDep + await _addDepFromPubdev(pubspec.devDependencies);
    }
    if (pubspec.environmentSDK.isNotEmpty) {
      devDep + await _addDepFromPubdev(pubspec.devDependencies);
    }

    return {
      'name': pubspec.name,
      'description': pubspec.description,
      "publish_to": '"none"',
      'version': pubspec.version,
      'homepage': pubspec.homepage,
      'documentation': pubspec.documentation,
      'environment': {
        "sdk": pubspec.environmentSDK.isNotEmpty
            ? pubspec.environmentSDK
            : ">=2.18.4 <3.0.0"
      },
      'dependencies': dep,
      'dev_dependencies': devDep,
      if (otherAttributes != null) 'flutter': otherAttributes
    };
  }
}
