// ignore: depend_on_referenced_packages
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'dart:io';
import 'package:content_length_validator/content_length_validator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_helmet/shelf_helmet.dart';
import 'package:shelf_rate_limiter/shelf_rate_limiter.dart';
import 'env/Environment.dart';
import 'CustomResponses/responseCustom.dart';
import 'Root/Middleware/middlewareRoot.dart';
import 'Routers/01-BaseApiRoute.dart';

void main(List<String> args) async {
  withHotreload(
    () => createServer(),
    onReloaded: () => print('onReloaded'),
    onHotReloadNotAvailable: () => print('onHotReloadNotAvailable'),
    onHotReloadAvailable: () => print('onHotReloadAvailable'),
    onHotReloadLog: (log) => print('onHotReloadLog'),
    logLevel: Level.INFO,
  );
}

Future<HttpServer> createServer() async {
  final memoryStorage = MemStorage();
  final rateLimiter = ShelfRateLimiter(
      storage: memoryStorage, duration: Duration(seconds: 60), maxRequests: 10);
  const maxContentLength = 5 * 1024 * 1024;

  final handler = Pipeline()
      // .addMiddleware(enforceSSL())

      .addMiddleware(helmet())
      .addMiddleware(rateLimiter.rateLimiter())
      .addMiddleware(
        maxContentLengthValidator(
            maxContentLength: maxContentLength,
            errorResponse: ResponseCustom.forbiddenResponse(
                responseMap: {'message': 'Your body is too long'})),
      )
      .addMiddleware(middlewareRoot())
      .addMiddleware(logRequests())
      .addHandler(BaseApiRoute().router);

  // For running in containers, we respect the PORT environment variable.

  final server = await serve(handler, Environment.ip, Environment.port);
  print('Server listening on http://${server.address.host}:${server.port}');
  return server;
}

// 200 OK: The request has succeeded and the response contains the requested information.
// 201 Created: The request has been fulfilled and a new resource has been created.
// 204 No Content: The server has successfully processed the request, but there is no response body to return.
// 304 Not Modified: The requested resource has not been modified since the last time it was accessed, so the server is not returning it again.
// 400 Bad Request: The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax).
// 401 Unauthorized: The request requires user authentication or the authentication has failed.
// 403 Forbidden: The server understood the request but refuses to authorize it.
// 404 Not Found: The server cannot find the requested resource.
// 429 Too Many Requests: The user has sent too many requests in a given amount of time.
// 500 Internal Server Error: A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.


// 200 OK: نجحت الطلب والاستجابة تحتوي على المعلومات المطلوبة.
// 201 Created: تم تحقيق الطلب وتم إنشاء مورد جديد.
// 204 No Content: نجح الخادم في معالجة الطلب بنجاح، لكنه ليس هناك جسم استجابة ليتم إرجاعه.
// 304 Not Modified: لم يتم تعديل المورد المطلوب منذ آخر مرة تم الوصول فيها إليه، لذلك لا يعيد الخادم إرساله مرة أخرى.
// 400 Bad Request: لا يمكن للخادم معالجة الطلب بسبب خطأ واضح في العميل (مثل تنسيق الطلب المشوه).
// 401 Unauthorized: يتطلب الطلب مصادقة المستخدم أو فشلت المصادقة.
// 403 Forbidden: فهم الخادم الطلب ولكنه يرفض تفويضه.
// 404 Not Found: الخادم لا يستطيع العثور على المورد المطلوب.
// 429 Too Many Requests: أرسل المستخدم الكثير من الطلبات في فترة زمنية محددة.
// 500 Internal Server Error: رسالة خطأ عامة، تعطى عندما يتم توفير حالة غير متوقعة ولا يوجد رسالة أكثر تحديدًا مناسبة.