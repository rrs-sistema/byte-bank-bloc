import 'package:http/http.dart';
import 'dart:convert';

import '../../http/http.dart';

const MESSAGES_URI = 'https://gist.githubusercontent.com/rrs-sistema/5f62bbc62d1e82e3e77d168f4493814e/raw/df6a1968bb1eb86ba730b888ab57eb8453b9aa22/';

class I18NWebClient {
  final String viewKey;

  I18NWebClient(this.viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get('$MESSAGES_URI$viewKey.json', headers: {
      'Content-Type':  'application/json;charset=UTF-8', 'Charset': 'utf-8'
    });
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}