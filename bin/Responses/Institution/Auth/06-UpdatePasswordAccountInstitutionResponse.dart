import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionAuth.dart';
import '../../../ValidateClass/ValidationClass.dart';

updatePasswordAccountInstitutionResponse(Request req) async {
  try {
    final authorization = req.headers["Authorization"].toString().trim();
    final readBody = json.decode(await req.readAsString());

    if (readBody["password"] == null) {
      throw FormatException('Email and Password is required');
    }
    await ValidationClass().validatePassword(password: readBody["password"]);

    Map<String, dynamic>? institutionAccount =
        await SupabaseInstitutionAuth.updatePassword(
            token: authorization, password: readBody["password"]);

    return ResponseCustom.successResponse(
        responseMap: institutionAccount,
        message: 'The password has been updated successfully');
  } on FormatException catch (error) {
    if (error.message == "Invalid payload" ||
        error.message == "Invalid token") {
      return ResponseCustom.forbiddenResponse(
          message: 'Token is invalid or already expired');
    }
    return ResponseCustom.forbiddenResponse(message: error.message.toString());
  }
}
