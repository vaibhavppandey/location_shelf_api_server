import 'helpers.dart';
import 'dart:convert' as convert;

import 'package:shelf/shelf.dart';

import 'package:http/http.dart' as http;

Future<Response> rootHandler(Request request) async {
  final body = "<html><body><h1>Hello World!<h1></body></html>";
  return Response.ok(body, headers: {'Content-type': 'text/html'});
}

Future<Response> locationHandler(Request request) async {
  final random = request.url.hasQuery
      ? convert.jsonDecode(request.url.queryParameters["random"]!)
      : false;
  String? ip = await (random ? getRandomIP() : getIP());
  http.Response response = await http.get(getLocationUri(ip));
  String? location;
  if (response.statusCode == 200) {
    final decodedJson = convert.jsonDecode(response.body);
    location = decodedJson['country'];
  }
  return Response.ok(convert.jsonEncode({"ip": ip, "location": location}),
      headers: {'Content-type': "application/json"});
}

Future<Response> ipHandler(Request request) async {
  final bool random = request.url.hasQuery
      ? convert.jsonDecode(request.url.queryParameters["random"]!)
      : false;
  final String? ip = await (random ? getRandomIP() : getIP());
  return Response.ok(convert.jsonEncode({"ip": ip}),
      headers: {'Content-type': 'application/json'});
}

Future<Response> echoHandler(Request request, String message) async =>
    await Future.delayed(const Duration(seconds: 2),
        () => Response.ok('Testing message: $message\n'));
