import 'dart:io';

import 'package:content_length_validator/content_length_validator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_helmet/shelf_helmet.dart';
import 'package:shelf_rate_limiter/shelf_rate_limiter.dart';

import 'Base/baseRouter.dart';
import 'Method/responseCustom.dart';
import 'Middleware/middlewareRoot.dart';
import 'package:sanitize_html/sanitize_html.dart' as sanitizeHtml;

Future<HttpServer> createServer() async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  final memoryStorage = MemStorage();
  final rateLimiter = ShelfRateLimiter(
      storage: memoryStorage, duration: Duration(seconds: 60), maxRequests: 10);
  const maxContentLength = 5 * 1024 * 1024;

  final handler = Pipeline()
      // .addMiddleware(enforceSSL())
      .addMiddleware(logRequests())
      .addMiddleware(rateLimiter.rateLimiter())
      .addMiddleware(
        maxContentLengthValidator(
            maxContentLength: maxContentLength,
            errorResponse: ResponseCustom.forbiddenResponse(
                responseMap: {'message': 'Your body is too long'})),
      )
      .addMiddleware(helmet())
      .addMiddleware(middlewareRoot())
      .addHandler(BaseRouter().router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on http://${server.address.host}:${server.port}');
  return server;
}


//--------

