import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../ValidateClass/ValidationClass.dart';

restPasswordAccountInstitutionResponse(Request req) async {
  try {
    final readBody = json.decode(await req.readAsString());
    if (readBody["email"] == null) {
      throw FormatException('Email is required');
    }
    await ValidationClass().validateEmail(email: readBody["email"]);
    Map<String, dynamic>? institutionAccount;

    await SupabaseInstitutionAuth.restPassword(email: readBody["email"]);

    return ResponseCustom.successResponse(
        responseMap: institutionAccount,
        message: 'It has been sent to your email');
  } on FormatException catch (error) {
    return ResponseCustom.forbiddenResponse(message: error.message.toString());
  }
}
