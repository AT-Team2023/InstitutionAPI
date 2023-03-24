import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:supabase/supabase.dart';

import '../../../../Services/supabase/Institution/registrationInstitution.dart';
import 'Create_Account_Institution.dart';

class RestPasswordInstitution {
  Handler get router {
    final router = Router();
    final pipeline = Pipeline()
        .addMiddleware((innerHandler) => (Request req) {
              return innerHandler(req);
            })
        .addHandler(response);

    return pipeline;
  }
}

Future<Response> response(Request req) async {
  RegistrationInstitution institutionSupbase = RegistrationInstitution();
  try {
    // Read the request body.
    var requestBody = await req.readAsString();
    // convert the request body to Map.

    // Validate and sanitize the user input.
    validateRequestBodyEmpty(requestBody: requestBody);
    validateFoundKeyInJson(requestBody: requestBody, keyName: "email");
    final requestBodyJson = jsonDecode(requestBody);
    validateEmail(email: requestBodyJson["email"]);

    Map<String, dynamic> user =
        await institutionSupbase.restPassword(email: requestBodyJson["email"]);
    // ---------------

    return Response.ok(jsonEncode(user),
        headers: {'content-type': 'application/json'});
  } on FormatException catch (error) {
    return Response(404,
        body: jsonEncode({"message": error.message}),
        headers: {'content-type': 'application/json'});
  }
}
