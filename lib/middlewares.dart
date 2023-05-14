import 'package:shelf/shelf.dart';

Middleware changeContentTypeMiddleware() {
  return (Handler innerHandler) => (Request request) async {
        final Response response = await innerHandler(request);
        // if root ? return (html : json) type
        final String contentType =
            request.url.toString().isEmpty ? 'text/html' : 'application/json';
        final Response mutatedResponse =
            response.change(headers: {'Content-type': contentType});
        return mutatedResponse;
      };
}
