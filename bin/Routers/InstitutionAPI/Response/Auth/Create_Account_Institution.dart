// ignore_for_file: unrelated_type_equality_checks, empty_constructor_bodies

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../Root/Method/responseCustom.dart';
import '../../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../../ValidateClass/ValidationClass.dart';

class CreateAccountInstitution {
  Handler get router {
    final router = Router();
    final pipeline = Pipeline()
        .addMiddleware((innerHandler) => (Request req) {
              return innerHandler(req);
            })
        .addHandler(response);

    return pipeline;
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
      validation.validateFoundKeyInJson(
          requestBody: requestBody, keyName: "name");
      validation.validateFoundKeyInJson(
          requestBody: requestBody, keyName: "email");
      validation.validateFoundKeyInJson(
          requestBody: requestBody, keyName: "password");

      final requestBodyJson = jsonDecode(requestBody);
      validation.validateEmail(email: requestBodyJson["email"]);
      validation.validatePassword(password: requestBodyJson["password"]);

      Map<String, dynamic> response = await institutionSuapbase.createAccount(
        email: requestBodyJson["email"],
        password: requestBodyJson["password"],
      );
      // ---------------

      return ResponseCustom.successResponse(responseMap: response);
    } on FormatException catch (error) {
      return ResponseCustom.forbiddenResponse(
          responseMap: {"message": error.message});
    }
  }
}
