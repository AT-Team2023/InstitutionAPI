import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../ValidateClass/ValidationClass.dart';

loginAccountInstitutionResponse(Request req) async {
  try {
    final readBody = json.decode(await req.readAsString());
    if (readBody["email"] == null || readBody["password"] == null) {
      throw FormatException('Email and Password is required');
    }
    await ValidationClass().validateEmail(email: readBody["email"]);
    await ValidationClass().validatePassword(password: readBody["password"]);
    Map<String, dynamic>? institutionAccount;

    institutionAccount = await SupabaseInstitutionAuth.login(
        email: readBody["email"], password: readBody["password"]);

    return ResponseCustom.successResponse(
        responseMap: institutionAccount, message: 'Successfully logged in');
  } on FormatException catch (error) {
    return ResponseCustom.forbiddenResponse(message: error.message.toString());
  }
}
