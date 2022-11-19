enum MainCommand {
  load,
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
