import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../ValidateClass/ValidationClass.dart';

GetCodeConfirmAccountInstitutionResponse(Request req) async {
  try {
    final readBody = json.decode(await req.readAsString());
    if (readBody["email"] == null) {
      throw FormatException('Email and Code verification is required');
    }
    await ValidationClass().validateEmail(email: readBody["email"]);

    final institutionAccount =
        await SupabaseInstitutionAuth.getCodeConfirmSignUp(
            email: readBody["email"]);
    return ResponseCustom.successResponse(message: institutionAccount);
  } on FormatException catch (error) {
    return ResponseCustom.forbiddenResponse(message: error.message);
  }
}
