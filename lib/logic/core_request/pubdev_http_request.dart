import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const base = 'https://pub.dev/api/packages';
const headers = {
  HttpHeaders.cacheControlHeader: 'public, max-age=28800',
  HttpHeaders.contentEncodingHeader: 'gzip',
  HttpHeaders.contentTypeHeader: 'application/json; charset="utf-8"'
};

mixin PubDevHttpRequest {
  Future<Map<String, dynamic>> getPackage(String name) async {
    http.Response response =
        await http.get(Uri.parse('$base/$name'), headers: headers);
    if (response.statusCode == 200) {
      var raw = Map<String, dynamic>.from((json.decode(response.body)));
      var name = raw['name'];
      String latestVersion =
          Map<String, dynamic>.from(raw['latest'])['version'];
      return {name: '^$latestVersion'};
    }
    stdout.write('\n${response.body}\n');
    throw Exception('Http Package network Error');
  }
}
