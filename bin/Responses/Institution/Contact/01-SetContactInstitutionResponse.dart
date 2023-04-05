import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';
import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionDatabase.dart';

setContactInstitutionResponse(Request req) async {
  try {
    String? yourToken = req.headers['Authorization'].toString().trim();
    final readBody = json.decode(await req.readAsString());
    final contact =
        await SupabaseInstitutionDataBase.setNewContactProfileInstitution(
            updateData: readBody, token: yourToken);
    return ResponseCustom.successResponse(
        message: "Contact added", responseMap: contact);
  } on FormatException catch (error) {
    //response error if account not create
    return ResponseCustom.forbiddenResponse(message: error.message);
  }
}

//id_auth
//institution