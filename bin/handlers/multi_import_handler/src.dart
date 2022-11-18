import 'package:pub_cli/pub_cli.dart';
import 'package:pub_cli/repos/repos.dart';

import '../main_command_handler/help_unknown_cmd.dart';

void mulitImportHandler(List<String> arguments) {
  late bool isdevArg;
  var arg = _argCleanUp(arguments);

  if (arg[0].startsWith('-dev')) {
    arg[0] = arg[0].replaceAll('-dev', '').trim();
    isdevArg = true;
  } else {
    isdevArg = false;
  }

  var wrongInput = _checkIsAnyWrongInput(arg);

  if (wrongInput.isNotEmpty) {
    onUnknownCmd(wrongInput.join(','), description: 'Unexpected package name ');
  } else {
    var pub = PubspaceYaml(
        yamlRequestRepo: YamlRequestRepo('test'),
        dependencies: isdevArg ? [] : arg,
        devDependencies: isdevArg ? arg : []);
    pub.createNew();
  }
}

/*

Supporting Function
_____________________

*/

Iterable<String> _checkIsAnyWrongInput(List<String> arg) =>
    arg.where((e) => !e.contains(RegExp(r'^[a-z0-9]+$')));

List<String> _argCleanUp(List<String> arguments) {
  return arguments
      .join(',')
      .split(',')
      .map((e) => e.toLowerCase().trim())
      .toList();
}
