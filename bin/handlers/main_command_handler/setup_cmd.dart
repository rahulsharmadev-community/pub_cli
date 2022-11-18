import 'dart:io';
import 'help_unknown_cmd.dart';

void onSetupCmd() {
  var statment = '''
Set you own default pubspec.yaml dependencies.
      Choose any one
      1) dependencies
      2) dev_dependencies
''';
  stdout.write(statment);

  var choice = stdin.readLineSync();

  if (choice != '1' || choice != '2') {
    onUnknownCmd('choice');
  } else {
    stdout.write('Enter Packages name seprated with ,\n'
        '(note* : package name should be correct)');
    var inputs = _getInputs();
    var wrongInputs = _checkIsAnyWrongInput(inputs);
    if (wrongInputs.isNotEmpty) {
      onUnknownCmd(wrongInputs.join(','),
          description: 'Unexpected package name ');
    } else {
      // Go on

      
    }
  }
}

/*
__

*/
List<String> _getInputs() {
  var inputs = stdin.readLineSync()?.split(',');
  if (inputs == null) _getInputs();
  return inputs!;
}

List<String> _checkIsAnyWrongInput(List<String> arg) =>
    arg.where((e) => !e.contains(RegExp(r'^[a-z0-9]+$'))).toList();
