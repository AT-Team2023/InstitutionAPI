import 'package:http/http.dart';
import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import '../../../env/SupabaseConst.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'SupabaseInstitutionDatabase.dart';

class SupabaseInstitutionAuth {
  static SupabaseClient connect =
      SupabaseClient(SupabaseConst.url, SupabaseConst.secretKey);


  //----------------------- create new Account --------------------

  static createAccount(
      {required String email, required String password}) async {
    try {
      UserResponse institutionAccount = await connect.auth.admin.createUser(
          AdminUserAttributes(email: email, password: password, data: {
        "email": email,
      }));

      Map<String, dynamic> user = {
        "id_auth": institutionAccount.user?.id,
        "email": institutionAccount.user?.email,
      };

      await SupabaseInstitutionDataBase.addInstitution(institutionJson: user);

      return {
        "email": institutionAccount.user?.email,
        "id": institutionAccount.user?.id,
      };
    } on ClientException catch (error) {
      throw FormatException("Failed check your internet or contact with admin");
    } on AuthException catch (error) {
      customAuthException(exception: error);
    }
  }

  //----------------------- Confirm --------------------

  static confirmAccount(
      {required String email,
      required String code,
      required OtpType type}) async {
    try {
      AuthResponse? user =
          await connect.auth.verifyOTP(token: code, type: type, email: email);

      return {
        "accessToken": user.session?.accessToken,
        "expiresAt": user.session?.expiresAt,
        "refreshToken": user.session?.refreshToken,
        "id": user.session?.user.id,
        "email": user.session?.user.email,
      };
    } on ClientException catch (error) {
      throw FormatException("Failed check your internet or contact with admin");
    } on AuthException catch (error) {
      customAuthException(exception: error);
    }
  }
  //----------------------- login --------------------

  static login({
    required String email,
    required String password,
  }) async {
    SupabaseClient connect1;
    try {
      AuthResponse user = await connect.auth
          .signInWithPassword(email: email, password: password);

      return {
        "message": "Login is successfully",
        "accessToken": user.session?.accessToken,
        "refreshToken": user.session?.refreshToken,
        "id": user.session?.user.id,
        "expiresAt": user.session?.expiresAt
      };
    } on ClientException catch (error) {
      throw FormatException("Failed check your internet or contact with admin");
    } on AuthException catch (error) {
      customAuthException(exception: error);
    }
  }

  //----------------------- login --------------------

  static restPassword({
    required String email,
  }) async {
    try {
      // GenerateLinkResponse rest = await connect.auth.admin
      //     .generateLink(type: GenerateLinkType.magiclink, email: email);

      await connect.auth.resetPasswordForEmail(email);
    } on ClientException catch (error) {
      throw FormatException("Failed check your internet or contact with admin");
    } on AuthException catch (error) {
      customAuthException(exception: error);
    }
  }

  //----------------------- login --------------------

  //----------------------- login --------------------

  static updatePassword({
    required String token,
    required String password,
  }) async {
    try {
      bool hasExpired = JwtDecoder.isExpired(token);
      Map<String, dynamic> userData = JwtDecoder.decode(token);
      if (hasExpired) {
        throw FormatException("Token is invalid or already expired");
      }
      UserResponse user = await connect.auth.admin.updateUserById(
          userData["sub"],
          attributes: AdminUserAttributes(
              email: userData["email"], password: password));
      var tokenJWT = token.substring(7, token.length);
      print(tokenJWT);

      return {
        "id": user.user?.id,
        "email": user.user?.email,
      };
    } on ClientException catch (error) {
      throw FormatException("Failed check your internet or contact with admin");
    } on AuthException catch (error) {
      customAuthException(exception: error);
    }
  }

  static getCodeConfirmSignUp({
    required String email,
  }) async {
    try {
      await connect.auth.signInWithOtp(email: email);

      return "Code send to your email";
    } on ClientException catch (error) {
      throw FormatException("Failed check your internet or contact with admin");
    } on AuthException catch (error) {
      customAuthException(exception: error);
    }
  }
}

customAuthException({required AuthException exception}) {
  switch (exception.message) {
    case "Invalid login credentials":
      throw FormatException('The email or password is incorrect');
    case "Invalid payload":
      throw FormatException('Sorry, the token is incorrect');

    default:
      throw FormatException(exception.message);
  }
}
