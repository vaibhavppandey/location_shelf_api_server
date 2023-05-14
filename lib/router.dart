import "package:shelf_router/shelf_router.dart";
import "package:http_sth_server/handlers.dart" as handlers;

// Configure routes.
final router = Router()
  ..get('/', handlers.rootHandler)
  ..get('/test/<message>', handlers.echoHandler)
  ..get('/location', handlers.locationHandler)
  ..get('/ip', handlers.ipHandler);
