import 'dart:convert';

import 'package:shelf/shelf.dart';

class ResponseCustom {
  static Response successResponse(
      {Map<String, dynamic>? responseMap, String? message = "successfully"}) {
    //200 OK: نجحت الطلب والاستجابة تحتوي على المعلومات المطلوبة.
    return Response(200,
        body: jsonEncode(
            {"statusCode": 200, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response createdResponse(
      {Map<String, dynamic>? responseMap, String? message = "Created"}) {
//201 Created: تم تحقيق الطلب وتم إنشاء مورد جديد.
    return Response(201,
        body: jsonEncode(
            {"statusCode": 201, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response notModified(
      {Map<String, dynamic>? responseMap, String? message = "Not Modified"}) {
    //304 Not Modified: لم يتم تعديل المورد المطلوب منذ آخر مرة تم الوصول فيها إليه، لذلك لا يعيد الخادم إرساله مرة أخرى.
    return Response(304,
        body: jsonEncode(
            {"statusCode": 304, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response badRequest(
      {Map<String, dynamic>? responseMap, String? message = "Bad Request"}) {
    //400 Bad Request: لا يمكن للخادم معالجة الطلب بسبب خطأ واضح في العميل (مثل تنسيق الطلب المشوه).
    return Response(400,
        body: jsonEncode(
            {"statusCode": 400, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response unauthorizedResponse(
      {Map<String, dynamic>? responseMap, String? message = "Unauthorized"}) {
    //401 Unauthorized: يتطلب الطلب مصادقة المستخدم أو فشلت المصادقة.
    return Response(401,
        body: jsonEncode(
            {"statusCode": 401, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response notFoundResponse(
      {Map<String, dynamic>? responseMap, String? message = "Not Found"}) {
    //404 Not Found: الخادم لا يستطيع العثور على المورد المطلوب.
    return Response(404,
        body: jsonEncode(
            {"statusCode": 404, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response toManyRequestsResponse(
      {Map<String, dynamic>? responseMap,
      String? message = "Too Many Requests"}) {
    //429 Too Many Requests: أرسل المستخدم الكثير من الطلبات في فترة زمنية محددة.
    return Response(429,
        body: jsonEncode(
            {"statusCode": 429, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response serverErrorResponse(
      {Map<String, dynamic>? responseMap, String? message = "successfully"}) {
    //500 Internal Server Error: رسالة خطأ عامة، تعطى عندما يتم توفير حالة غير متوقعة ولا يوجد رسالة أكثر تحديدًا مناسبة.
    return Response(500,
        body: jsonEncode(
            {"statusCode": 500, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }

  static Response forbiddenResponse(
      {Map<String, dynamic>? responseMap, String? message = "successfully"}) {
    //500 Internal Server Error: رسالة خطأ عامة، تعطى عندما يتم توفير حالة غير متوقعة ولا يوجد رسالة أكثر تحديدًا مناسبة.
    return Response(403,
        body: jsonEncode(
            {"statusCode": 403, "message": message, ...?responseMap}),
        headers: {'Content-Type': 'application/json'});
  }
}
