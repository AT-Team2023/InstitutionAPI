// ignore_for_file: unrelated_type_equality_checks, empty_constructor_bodies

import 'dart:convert';

import 'package:regexed_validator/regexed_validator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:string_validator/string_validator.dart';
import '../../../../Model/InstitutionRegistration.dart';
import '../../../../Services/supabase/Institution/registrationInstitution.dart';

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

  Future<Response> response(Request req) async {
    RegistrationInstitution institutionSupbase = RegistrationInstitution();
    try {
      // Read the request body.
      var requestBody = await req.readAsString();
      // convert the request body to Map.

      // Validate and sanitize the user input.
      validateRequestBodyEmpty(requestBody: requestBody);
      validateFoundKeyInJson(requestBody: requestBody, keyName: "name");
      validateFoundKeyInJson(requestBody: requestBody, keyName: "email");
      validateFoundKeyInJson(requestBody: requestBody, keyName: "password");

      final requestBodyJson = jsonDecode(requestBody);
      validateEmail(email: requestBodyJson["email"]);
      validatePassword(password: requestBodyJson["password"]);

      Map<String, dynamic> user = await institutionSupbase.createAccount(
        email: requestBodyJson["email"],
        password: requestBodyJson["password"],
      );
      // ---------------

      return Response.ok(jsonEncode(user),
          headers: {'content-type': 'application/json'});
    } on FormatException catch (error) {
      return Response(404,
          body: jsonEncode({"message": error.message}),
          headers: {'content-type': 'application/json'});
    }
  }
}

validateRequestBodyEmpty({required String? requestBody}) {
  print(requestBody?.length);
  if (requestBody!.isEmpty || requestBody.length <= 8) {
    throw const FormatException(
        "The body must contain the values as json <Key,value>");
  }
}

validateFoundKeyInJson(
    {required String? requestBody, required String keyName}) {
  final regex = RegExp('"$keyName"\\s*:\\s*');

  if (!regex.hasMatch(json.encode(jsonDecode(requestBody!)))) {
    throw FormatException('The body should has a key called \'$keyName\'');
  }
}

validatePassword({required String password}) {
  if (!validator.password(password) || password.length > 25) {
    throw FormatException(
        'please create a password that is between 8 and 25 characters long, and includes a combination of uppercase and lowercase letters, numbers, and symbols');
  }
}

validateEmail({required String email}) {
  if (!validator.email(email)) {
    throw FormatException(
        'Please ensure that you have entered a valid email correctly.');
  }
}

validateCode({required String code}) {
  if (!isNumeric(code)) {
    throw FormatException(
        'Please ensure that you have entered a valid code correctly.');
  }
}

validateID({required String id}) {
  if (!isUUID(id)) {
    throw FormatException(
        'Please ensure that you have entered a valid UUID correctly.');
  }
}
