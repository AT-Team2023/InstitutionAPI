import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../ValidateClass/ValidationClass.dart';

createAccountInstitutionResponse(Request req) async {
  try {
    //read body as String and convert to json
    final readBody = json.decode(await req.readAsString());

    //check if body contained keys (email and password)
    if (readBody["email"] == null || readBody["password"] == null) {
      throw FormatException('Email and Password is required');
    }

    //Validation Key of body json
    await ValidationClass().validateEmail(email: readBody["email"]);
    await ValidationClass().validatePassword(password: readBody["password"]);

    //call method create account from class SupabaseInstitutionAuth
    final institutionAccount = await SupabaseInstitutionAuth.createAccount(
        email: readBody["email"], password: readBody["password"]);
    //response success if account create
    return ResponseCustom.successResponse(
        responseMap: institutionAccount,
        message: 'Account successfully created');
  } on FormatException catch (error) {
    //response error if account not create
    return ResponseCustom.forbiddenResponse(message: error.message);
  }
}
