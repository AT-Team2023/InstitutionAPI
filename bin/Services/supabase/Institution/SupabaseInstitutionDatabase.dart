import 'package:supabase/supabase.dart';

import '../../../Const_data/SupabaseConst.dart';

class SupabaseInstitutionDataBase {
  SupabaseClient _connect =
      SupabaseClient(SupabaseConst.url, SupabaseConst.secretKey);
  SupabaseInstitution() {
    _connect = SupabaseClient(SupabaseConst.url, SupabaseConst.secretKey);
  }

  Future<void> createTable() async {
    try {
      final testss = await _connect.from("course").insert({
        'id': 567890,
        'name': 'supabot',
      });
    } catch (error) {
      print(error);
    }
  }
}
