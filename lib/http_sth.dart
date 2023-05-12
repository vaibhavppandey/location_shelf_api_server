import 'dart:convert' show jsonDecode;

import 'package:http/http.dart' as http;

Future<int> main() async {
  // This example uses the Google Books API to search
  // for books about HTTP. For details, see
  // https://developers.google.com/books/docs/overview
  // String response = await http
  //     .read(Uri.parse("http://ip-api.com/json/106.208.48.30?fields=655385"));
  print(await _getLocation());
  return 0;
}

Future<String> _getLocation() async {
  String ip = await _getIp() ?? "182.79.4.245";
  http.Response response =
      await http.get(Uri.http("ip-api.com", "/json/$ip", {"fields": "655385"}));
  String location = '';
  if (response.statusCode == 200) {
    final decodedJson = jsonDecode(response.body);
    location = decodedJson['country'];
  }
  return location;
}

Future<String?> _getIp() async {
  http.Response response =
      await http.get(Uri.https("api.ipify.org", '', {"format": "json"}));
  String? ip;
  if (response.statusCode == 200) {
    ip = jsonDecode(response.body)['ip'];
  }
  return ip;
}
