import 'package:http/http.dart' as http;

class Networking {

  static Future<String> post(url, body, {headers}) async {
    print(url);

    http.Response res = await http.post(Uri.parse(url), body: body, headers: headers);
    return res.body;
  }

  static Future<String> get(url) async {
    http.Response res = await http.get(url);
    return res.body;
  }
}
