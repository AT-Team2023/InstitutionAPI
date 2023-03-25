import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../Root/Method/responseCustom.dart';
import '../../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../../ValidateClass/ValidationClass.dart';

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

//---------------------Response----------------------------

Future<Response> response(Request req) async {
  SupabaseInstitutionAuth institutionSuapbase = SupabaseInstitutionAuth();
  try {
        ValidationClass validation = ValidationClass();

    // Read the request body.
    var requestBody = await req.readAsString();
    // convert the request body to Map.

    // Validate and sanitize the user input.
    validation.validateRequestBodyEmpty(requestBody: requestBody);
    validation.validateFoundKeyInJson(requestBody: requestBody, keyName: "email");
    final requestBodyJson = jsonDecode(requestBody);
    validation.validateEmail(email: requestBodyJson["email"]);

    Map<String, dynamic> response =
        await institutionSuapbase.restPassword(email: requestBodyJson["email"]);
    // ---------------

    return ResponseCustom.successResponse(responseMap: response);

  } on FormatException catch (error) {
    return ResponseCustom.forbiddenResponse(
        responseMap: {"message": error.message});
  }
}
