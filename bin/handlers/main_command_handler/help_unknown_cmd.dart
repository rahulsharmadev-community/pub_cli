import 'dart:io';

void onHelpCmd() {
  var text = '''
Available commands:
  load             Load default flutter packages in pubspec file.
    -firebase      Load firebase default in pubspec file.
  setup            Create your own default packages in temp folder.
  help             For more information about a commands.
  cc               See License\n
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
