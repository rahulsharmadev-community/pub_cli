import 'dart:convert';

class Pubspec {
  const Pubspec({
    required this.name,
    required this.description,
    required this.version,
    required this.homepage,
    required this.documentation,
    required this.environmentSDK,
    required this.dependencies,
    required this.devDependencies,
  });

  final String name;
  final String description;
  final String version;
  final String homepage;
  final String documentation;
  final String environmentSDK;
  final List<String> dependencies;
  final List<String> devDependencies;

  Pubspec copyWith({
    String? name,
    String? description,
    String? version,
    String? homepage,
    String? documentation,
    String? environmentSDK,
    List<String>? dependencies,
    final List<String>? devDependencies,
  }) =>
      Pubspec(
        name: name ?? this.name,
        description: description ?? this.description,
        version: version ?? this.version,
        homepage: homepage ?? this.homepage,
        documentation: documentation ?? this.documentation,
        environmentSDK: environmentSDK ?? this.environmentSDK,
        dependencies: dependencies ?? this.dependencies,
        devDependencies: devDependencies ?? this.devDependencies,
      );

  factory Pubspec.fromJson(String str) => Pubspec.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pubspec.fromMap(Map<String, dynamic> map) => Pubspec(
        name: map["name"],
        description: map["description"],
        version: map["version"],
        homepage: map["homepage"],
        documentation: map["documentation"],
        environmentSDK: map["environmentSDK"],
        dependencies: List<String>.from(map["dependencies"].map((x) => x)),
        devDependencies:
            List<String>.from(map["dev_dependencies"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "version": version,
        "homepage": homepage,
        "documentation": documentation,
        "environmentSDK": environmentSDK,
        "dependencies": List<dynamic>.from(dependencies.map((x) => x)),
        "dev_dependencies": List<dynamic>.from(devDependencies.map((x) => x))
      };

  static Pubspec get kdefault => Pubspec(
      name: 'New Project',
      description: 'A Very Good Project created by Pub CLI',
      version: '1.0.0',
      homepage: '',
      documentation: '',
      environmentSDK: '>=2.18.4 <3.0.0',
      dependencies: ['flutter_bloc', 'equatable', 'bloc_test', 'jars', 'http'],
      devDependencies: ['lints']);
}
