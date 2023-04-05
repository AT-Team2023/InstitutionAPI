import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';

import '../../../CustomResponses/responseCustom.dart';
import '../../../Services/supabase/Institution/SupabaseInstitutionDatabase.dart';

updateProfileInstitutionResponse(Request req) async {
  try {
    String? yourToken = req.headers['Authorization'].toString().trim();
    final readBody = json.decode(await req.readAsString());
    Map<String, dynamic> dataToken = JwtDecoder.decode(yourToken);

    var user = await SupabaseInstitutionDataBase.updateProfileInstitution(
        updateData: readBody, id: dataToken['sub']);
    return ResponseCustom.successResponse(responseMap: user);
  } on FormatException catch (error) {
    //response error if account not create
    return ResponseCustom.forbiddenResponse(message: error.message);
  }
}

//id_auth
//institution