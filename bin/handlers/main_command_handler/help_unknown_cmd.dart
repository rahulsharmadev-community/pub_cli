import 'dart:io';

void onHelpCmd() {
  var text = '''
Available commands:
  run      Analyze Dart code in a directory.
  setup    Compile Dart to various formats.
  help     For more information about a commands.
  cc       See License\n
''';
  stdout.write(text);
}

void onUnknownCmd(String cmd,
    {String description = 'Could not find a command'}) {
  var text = '''
$description "$cmd".

Usage: pubcli <command|pubcli-file> [arguments]\n
''';
  stdout.write(text);
  onHelpCmd();
}
