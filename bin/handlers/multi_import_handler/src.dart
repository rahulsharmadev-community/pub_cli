import 'package:pub_cli/pubspace_yaml.dart';
import 'package:pub_cli/logic/repos.dart';

import '../main_command_handler/help_unknown_cmd.dart';

void mulitImportHandler(List<String> arguments) {
  late bool isdevArg;
  var arg = _argCleanUp(arguments);

  if (arg[0] == '-dev') {
    arg.removeAt(0);
    isdevArg = true;
  } else {
    isdevArg = false;
  }

  var wrongInput = _checkIsAnyWrongInput(arg);

  if (wrongInput.isNotEmpty) {
    onUnknownCmd(wrongInput.join(','), description: 'Unexpected package name ');
  } else {
    PubspaceYaml(
            dependencies: isdevArg ? [] : arg,
            devDependencies: isdevArg ? arg : [])
        .createOrEdit();
  }
}

/*

Supporting Function
_____________________

*/

Iterable<String> _checkIsAnyWrongInput(List<String> arg) =>
    arg.where((e) => !e.contains(RegExp(r'^[a-z0-9_]+$')));

List<String> _argCleanUp(List<String> arguments) {
  return arguments
      .join(',')
      .split(',')
      .map((e) => e.toLowerCase().trim())
      .toList();
}
