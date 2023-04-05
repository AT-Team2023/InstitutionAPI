import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../ValidateClass/ValidationClass.dart';

confirmCreateAccountInstitutionResponse(Request req) async {
  try {
    final readBody = json.decode(await req.readAsString());
    if (readBody["email"] == null || readBody["code"] == null) {
      throw FormatException('Email and Code verification is required');
    }
    await ValidationClass().validateEmail(email: readBody["email"]);
    await ValidationClass().validateCode(code: readBody["code"]);

    final institutionAccount = await SupabaseInstitutionAuth.confirmAccount(
        email: readBody["email"], code: readBody["code"], type: OtpType.signup);
    return ResponseCustom.successResponse(
        responseMap: institutionAccount,
        message: 'Account successfully Verified');
  } on FormatException catch (error) {
    return ResponseCustom.forbiddenResponse(message: error.message);
  }
}
