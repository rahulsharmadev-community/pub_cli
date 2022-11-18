import 'package:pub_cli/pub_cli.dart';
import 'package:pub_cli/repos/repos.dart';
import '../../pub_cli.dart';

void onRunCmd() async {
  var pub = PubspaceYaml(
      yamlRequestRepo: YamlRequestRepo('test'),
      dependencies: dependencies,
      devDependencies: devDependencies);
  pub.createNew();
}
