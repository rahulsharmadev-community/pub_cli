import 'package:pub_cli/pubspace_yaml.dart';

void onRunCmd() async {
  var cached = await PubspaceYaml.getCachedPubspec;

  PubspaceYaml(
          dependencies: cached.dependencies,
          devDependencies: cached.devDependencies)
      .createOrEdit();
}
