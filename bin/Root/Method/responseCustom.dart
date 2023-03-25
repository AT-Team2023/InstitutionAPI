import 'dart:convert';

import 'package:shelf/shelf.dart';

class ResponseCustom {
  static Response successResponse({Map? responseMap}) {
    //200 OK: نجحت الطلب والاستجابة تحتوي على المعلومات المطلوبة.
    return Response(200,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response createdResponse({Map? responseMap}) {
//201 Created: تم تحقيق الطلب وتم إنشاء مورد جديد.
    return Response(201,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response notModified({Map? responseMap}) {
    //304 Not Modified: لم يتم تعديل المورد المطلوب منذ آخر مرة تم الوصول فيها إليه، لذلك لا يعيد الخادم إرساله مرة أخرى.
    return Response(304,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response badRequest({Map? responseMap}) {
    //400 Bad Request: لا يمكن للخادم معالجة الطلب بسبب خطأ واضح في العميل (مثل تنسيق الطلب المشوه).
    return Response(400,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response unauthorizedResponse({Map? responseMap}) {
    //401 Unauthorized: يتطلب الطلب مصادقة المستخدم أو فشلت المصادقة.
    return Response(401,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response notFoundResponse({Map? responseMap}) {
    //404 Not Found: الخادم لا يستطيع العثور على المورد المطلوب.
    return Response(404,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response toManyRequestsResponse({Map? responseMap}) {
    //429 Too Many Requests: أرسل المستخدم الكثير من الطلبات في فترة زمنية محددة.
    return Response(429,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response serverErrorResponse({Map? responseMap}) {
    //500 Internal Server Error: رسالة خطأ عامة، تعطى عندما يتم توفير حالة غير متوقعة ولا يوجد رسالة أكثر تحديدًا مناسبة.
    return Response(500,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }

  static Response forbiddenResponse({Map? responseMap}) {
    //500 Internal Server Error: رسالة خطأ عامة، تعطى عندما يتم توفير حالة غير متوقعة ولا يوجد رسالة أكثر تحديدًا مناسبة.
    return Response(403,
        body: jsonEncode(responseMap),
        headers: {'Content-Type': 'application/json'});
  }
}
