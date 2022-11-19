import 'enums.dart';
import 'handlers/_handler.dart';

const _firebase = [
  'google_sign_in',
  'firebase_core',
  'firebase_auth',
  'cloud_firestore',
  'firebase_messaging',
  'firebase_storage',
];
void main(List<String> arg) {
  if (arg.isEmpty) return;
  if (arg.length == 2 && arg[1] == '-firebase') arg = _firebase;
  return arg.length == 1
      ? mainCommandHandler(arg.first)
      : mulitImportHandler(arg);
}

void mainCommandHandler(String arguments) {
  switch (MainCommand.getBy(arguments)) {
    case MainCommand.load:
      return onRunCmd();
    case MainCommand.setup:
      return onSetupCmd();
    case MainCommand.cc:
      return onCcCmd();
    case MainCommand.help:
      return onHelpCmd();
    default:
      return onUnknownCmd(arguments);
  }
}
