import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:http_sth_server/handlers.dart' as handlers;

// Configure routes.
final _router = Router()
  ..get('/', handlers.rootHandler)
  ..get('/test/<message>', handlers.echoHandler)
  ..get('/location', handlers.locationHandler)
  ..get('/ip', handlers.ipHandler);

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  // content compression
  server.autoCompress = true;
  print(
      'Server listening on port ${server.port} and host: ${server.address.host}');
}
