import 'dart:math';
import 'dart:convert' as convert;

import 'package:shelf/shelf.dart';

import 'package:http/http.dart' as http;

Future<Response> rootHandler(Request request) async =>
    Response.ok('Hello, World!\n');

Future<Response> echoHandler(Request request, String message) async {
  await Future.delayed(const Duration(seconds: 2));
  return Response.ok('Testing123: $message\n');
}

Future<Response> locationHandler(Request request) async {
  final Map queries = request.requestedUri.queryParameters;
  String? ip =
      queries["random"] == "true" ? await _getRandoIp() : await getIp();
  http.Response response =
      await http.get(Uri.http("ip-api.com", "/json/$ip", {"fields": "655385"}));
  String? location;
  if (response.statusCode == 200) {
    final decodedJson = convert.jsonDecode(response.body);
    location = decodedJson['country'];
  }
  return Response.ok(convert.jsonEncode({"ip": ip, "location": location}),
      headers: {'Content-type': "application/json"});
}

Future<String?> getIp() async {
  http.Response response =
      await http.get(Uri.https("api.ipify.org", '', {"format": "json"}));
  String? ip;
  if (response.statusCode == 200) {
    ip = convert.jsonDecode(response.body)['ip'];
  }
  return ip;
}

Future<String?> _getRandoIp() async {
  final random = Random();
  final List<String> ips = [
    "18.194.217.1",
    "178.248.210.198",
    "200.53.20.122",
  ];
  return await Future.delayed(
      const Duration(seconds: 2), () => ips[random.nextInt(ips.length)]);
}
