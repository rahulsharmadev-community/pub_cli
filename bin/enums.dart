enum MainCommand {
  run,
  setup,
  cc,
  help,
  unknown;

  static MainCommand getBy(String name) {
    return MainCommand.values.firstWhere(
      (e) => e.name == name.toLowerCase().trim(),
      orElse: () => MainCommand.unknown,
    );
  }
}
