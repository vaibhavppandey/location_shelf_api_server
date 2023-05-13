import 'package:http/http.dart' as http;

import 'dart:math' show Random;
import 'dart:convert' as convert;

Uri get getIPUri => Uri.https("api.ipify.org", '', {"format": "json"});
Uri getLocationUri(String? ip) =>
    Uri.http("ip-api.com", "/json/$ip", {"fields": "655385"});

Future<String?> getIP() async {
  http.Response response = await http.get(getIPUri);
  String? ip;
  if (response.statusCode == 200) {
    ip = convert.jsonDecode(response.body)['ip'];
  }
  return ip;
}

Future<String?> getRandomIP() async {
  final random = Random();
  final List<String> ips = [
    "18.194.217.1",
    "178.248.210.198",
    "200.53.20.122",
  ];
  return await Future.delayed(
      const Duration(seconds: 2), () => ips[random.nextInt(ips.length)]);
}
