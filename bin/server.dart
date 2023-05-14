import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import "package:http_sth_server/router.dart" show router;
import 'package:http_sth_server/middlewares.dart' as middlewares;

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(middlewares.changeContentTypeMiddleware())
      .addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await shelf_io.serve(handler, ip, port);
  server.autoCompress = true; // content compression
  server.idleTimeout = const Duration(seconds: 10); // timeout
  print(
      'Server listening on port ${server.port} and address: ${server.address.host}');
  await Future.delayed(
      const Duration(minutes: 1), server.close); // automatically close server
  print("Server clolsed");
}
