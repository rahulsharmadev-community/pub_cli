import 'dart:io';
import 'package:json2yaml/json2yaml.dart';
import 'package:pub_cli/model/pubspec_attribute.dart';
import 'package:pub_cli/pubspace_yaml.dart';

import 'help_unknown_cmd.dart';

void onSetupCmd() async {
  Pubspec pubspec = await PubspaceYaml.getCachedPubspec;

  var statment = '''
---------------------------------------------------------------
|\n|\t${json2yaml(pubspec.toMap()).replaceAll('\n', '\n|\t')}
---------------------------------------------------------------
Set you own default pubspec.yaml dependencies.
      Choose any one
      1) Project Name,
      2) Project Description,
      3) Project Inital Version,
      4) Homepage,
      5) Documentation,
      6) Environment SDK Version,
      7) Dependencies,
      8) DevDependencies,
''';

  stdout.write(statment);
  var choice = stdin.readLineSync();
  if (choice != null && int.tryParse(choice) != null) {
    stdout.write('Set you default Packages:\n>');
    var input = stdin.readLineSync();
    if (input != null && input.isNotEmpty) {
      switch (int.tryParse(choice)) {
        case 1:
          PubspaceYaml.editCachedPubspec(pubspec.copyWith(name: input));
          break;
        case 2:
          PubspaceYaml.editCachedPubspec(pubspec.copyWith(description: input));
          break;
        case 3:
          PubspaceYaml.editCachedPubspec(pubspec.copyWith(version: input));
          break;
        case 4:
          PubspaceYaml.editCachedPubspec(pubspec.copyWith(homepage: input));
          break;
        case 5:
          PubspaceYaml.editCachedPubspec(
              pubspec.copyWith(documentation: input));
          break;
        case 6:
          PubspaceYaml.editCachedPubspec(
              pubspec.copyWith(environmentSDK: input));
          break;
        case 7:
          PubspaceYaml.editCachedPubspec(
              pubspec.copyWith(dependencies: _checkIsAnyWrongInput(input)));
          break;
        case 8:
          PubspaceYaml.editCachedPubspec(
              pubspec.copyWith(devDependencies: _checkIsAnyWrongInput(input)));
          break;
        default:
          return onUnknownCmd('choice');
      }
      var afterchange = '''
---------------------------------------------------------------
|\n|\t${json2yaml((await PubspaceYaml.getCachedPubspec).toMap()).replaceAll('\n', '\n|\t')}
---------------------------------------------------------------
''';
      stdout.write(afterchange);
    }
  }
}

List<String> _stringToList(String arguments) =>
    arguments.split(',').map((e) => e.toLowerCase().trim()).toList();

List<String> _checkIsAnyWrongInput(String input) {
  var inputs = _stringToList(input);
  var wrongInputs =
      inputs.where((e) => !e.contains(RegExp(r'^[a-z0-9_]+$'))).toList();
  return wrongInputs;
}
