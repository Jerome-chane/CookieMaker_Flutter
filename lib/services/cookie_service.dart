import 'dart:convert';
import 'package:cookie_maker/models/Data.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:http/http.dart' as http;

class CookieService {
  final String _url = Device.isIOS
      ? "http://127.0.0.1:5000/cookie"
      : "http://10.0.2.2:5000/cookie";

  Future<List<Cookie>> getCookies() async {
    dynamic response = await http.get(_url); //10.0.2.2 replace localhost
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Cookie.fromJson(job)).toList();
    } else {
      return null;
    }
  }

  Future<List<Cookie>> getNonShippedCookies() async {
    dynamic response = await http.get('$_url/nonshipped');
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Cookie.fromJson(job)).toList();
    } else {
      return null;
    }
  }

  Future<List<Cookie>> getShippedCookies() async {
    dynamic response = await http.get('$_url/shipped');
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Cookie.fromJson(job)).toList();
    } else {
      return null;
    }
  }

  Future<http.Response> createCookie(int quantity, String recieName) async {
    String jsonBody =
        jsonEncode({"NumberOfCookies": quantity, "recipeName": recieName});

    return http
        .post(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonBody)
        .then((response) {
      print("Response body: ${response.body}");
      return response;
    });
  }
}
