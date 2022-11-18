import 'enums.dart';
import 'handlers/_handler.dart';

const cachedFile = '__pubcli_cache_data';
var dependencies = ['flutter_bloc', 'bloc_test', 'jars', 'http'];
var devDependencies = ['lints'];

void main(List<String> arguments) {
  if (arguments.isEmpty) return;
  arguments.length == 1
      ? mainCommandHandler(arguments)
      : mulitImportHandler(arguments);
}

void mainCommandHandler(List<String> arguments) {
  switch (MainCommand.getBy(arguments.first)) {
    case MainCommand.run:
      return onRunCmd();
    case MainCommand.setup:
      return onSetupCmd();
    case MainCommand.cc:
      return onCcCmd();
    case MainCommand.help:
      return onHelpCmd();
    default:
      return onUnknownCmd(arguments.first);
  }
}
