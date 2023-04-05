import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:supabase/supabase.dart';

import '../../../env/SupabaseConst.dart';

class SupabaseInstitutionDataBase {
  static final SupabaseClient _connect =
      SupabaseClient(SupabaseConst.url, SupabaseConst.secretKey);

  static Future<void> addInstitution(
      {required Map<String, dynamic> institutionJson}) async {
    try {
      final testss = await _connect.from("institution").insert({
        'id_auth': institutionJson["id_auth"],
        'email': institutionJson["email"],
      });
    } catch (error) {
      print(error);
      throw FormatException("Database");
    }
  }

  //------- Get Profile ----
  static getProfileInstitution({required String id}) async {
    try {
      List<dynamic> data =
          await _connect.from('institution').select().eq("id_auth", id);
      print(data);
      return data.first;
    } catch (error) {
      print(error);
      throw FormatException("Database");
    }
  }

  //------- Update Profile ----
  static updateProfileInstitution(
      {required String id, required Map<String, dynamic> updateData}) async {
    try {
      Map staticData = await getProfileInstitution(id: id);

      List data = await _connect
          .from('institution')
          .update({
            ...updateData,
            "id": staticData["id"],
            "id_auth": staticData["id_auth"],
            "email": staticData["email"],
            "create_at": staticData["create_at"],
          })
          .eq("id_auth", id)
          .select();
      print(data);
      return data.first;
    } on PostgrestException catch (error) {
      throw FormatException(error.message);
    }
  }

  //------- add new Contact ----
  static setNewContactProfileInstitution(
      {required Map<String, dynamic> updateData, required String token}) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      Map<String, dynamic> dataInstitution =
          await getProfileInstitution(id: decodedToken["sub"]);

      List data = await _connect.from('contact').insert({
        ...updateData,
        "id_auth": dataInstitution["id_auth"],
        "id_institution": dataInstitution["id"]
      }).select();
      return data.first;
    } on PostgrestException catch (error) {
      throw FormatException(error.message.toString());
    }
  }
}
