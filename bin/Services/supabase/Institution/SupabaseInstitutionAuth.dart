import 'package:supabase/supabase.dart';

import '../../../Const_data/SupabaseConst.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'SupabaseInstitutionDatabase.dart';

class SupabaseInstitutionAuth {
  SupabaseClient _connect =
      SupabaseClient(SupabaseConst.url, SupabaseConst.secretKey);
  // SupabaseInstitution() {
  //   _connect = SupabaseClient(SupabaseConst.url, SupabaseConst.secretKey);
  // }

  Future<Map<String, dynamic>> createAccount(
      {required String email, required String password}) async {
    try {
      String timeNow =
          DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10);

      UserResponse? institutionAccount = await _connect.auth.admin.createUser(
          AdminUserAttributes(email: email, password: password, data: {
        "email": email,
        "password": password,
      }));
      await _connect.auth
          .signInWithOtp(email: email)
          .then((value) => print("sssssss"));
      return {
        "codeStatus": 200,
        "createdAt": institutionAccount.user?.createdAt,
        "email": institutionAccount.user?.email,
      };
    } on AuthException catch (error) {
      throw FormatException(error.message);
    }
  }

  //----------------------- Confirm --------------------

  Future<Map<String, dynamic>> confirmAccount(
      {required String email,
      required String code,
      required OtpType type}) async {
    try {
      SupabaseInstitutionDataBase test = SupabaseInstitutionDataBase();
      await test.createTable();
      AuthResponse? user =
          await _connect.auth.verifyOTP(token: code, type: type, email: email);

      return {
        "codeStatus": 200,
        "message": "The email has been confirmed successfully",
        "accessToken": user.session?.accessToken,
        "expiresAt": user.session?.expiresAt,
        "refreshToken": user.session?.refreshToken,
        "id": user.session?.user.id,
      };
    } on AuthException catch (error) {
      throw FormatException(error.message);
    }
  }
  //----------------------- login --------------------

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse user = await _connect.auth
          .signInWithPassword(email: email, password: password);

      return {
        "codeStatus": 200,
        "message": "Login is successfully",
        "accessToken": user.session?.accessToken,
        "refreshToken": user.session?.refreshToken,
        "id": user.session?.user.id,
        "expiresAt": user.session?.expiresAt
      };
    } on AuthException catch (error) {
      throw FormatException(error.message);
    }
  }

  //----------------------- login --------------------

  Future<Map<String, dynamic>> restPassword({
    required String email,
  }) async {
    try {
      // GenerateLinkResponse rest = await _connect.auth.admin
      //     .generateLink(type: GenerateLinkType.magiclink, email: email);

      await _connect.auth.resetPasswordForEmail(email);

      return {
        "codeStatus": 200,
        "message": "Reset Password is successfully",
      };
    } on AuthException catch (error) {
      throw FormatException(error.message);
    }
  }

  //----------------------- login --------------------

  Future<Map<String, dynamic>> confirmRestPassword({
    required String email,
    required String code,
  }) async {
    try {
      Map<String, dynamic> user = await confirmAccount(
          email: email, type: OtpType.recovery, code: code);

      return user;
    } on AuthException catch (error) {
      throw FormatException(error.message);
    }
  }

  //----------------------- login --------------------

  Future<Map<String, dynamic>> updatePassword({
    required String token,
    required String password,
  }) async {
    try {
      bool hasExpired = JwtDecoder.isExpired(token);
      if (hasExpired) {
        throw FormatException("Token is expired");
      }
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      UserResponse user = await _connect.auth.admin.updateUserById(
          decodedToken['sub'],
          attributes: AdminUserAttributes(password: password));
      return {
        "codeStatus": 200,
        "message": "Update Password is successfully",
        "id": user.user?.id,
        "email": user.user?.email,
      };
    } on AuthException catch (error) {
      throw FormatException(error.message);
    }
  }
}
