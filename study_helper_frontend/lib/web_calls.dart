import 'package:http/http.dart' as http;
import 'dart:convert';

var apiURL =
    'https://upqlg48wn7.execute-api.us-east-1.amazonaws.com/default/StudyHelperBacken';

Future<String> putRequest(
    String email, String hash, String salt, String data) async {
  http.Response response = await http.put(Uri.parse(apiURL),
      headers: {'Access-Control-Allow-Origin': '*'},
      body: jsonEncode(<String, String>{
        'email': email,
        'hash': hash,
        'salt': salt,
        'data': data,
      }));
  if (response.statusCode == 201) {
    return response.body;
  } else if (response.statusCode == 400) {
    throw response.body;
  } else {
    throw "what";
  }
}

Future<String> postRequest(String email, String? hash) async {
  var data = {};
  if (hash == null) {
    data = <String, String>{'email': email};
  } else {
    data = <String, String>{'email': email, 'hash': hash};
  }
  http.Response response = await http.post(Uri.parse(apiURL),
      headers: {'Access-Control-Allow-Origin': '*'}, body: jsonEncode(data));
  if (response.statusCode == 200) {
    return response.body;
  } else if (response.statusCode == 400) {
    throw response.body;
  } else {
    throw "what";
  }
}
