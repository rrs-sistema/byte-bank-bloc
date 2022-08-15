import 'package:http/http.dart';
import 'dart:convert';

import '../../http/http.dart';

const MESSAGES_URI = 'https://gist.githubusercontent.com/rrs-sistema/eaf85e00551430929d693239907b4557/raw/ae2009259809bc377421f94ee61f2688c47ab4c9/i18n.json';

class I18NWebClient {
  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get(MESSAGES_URI, headers: {
      'Content-Type':  'application/json;charset=UTF-8', 'Charset': 'utf-8'
    });
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}