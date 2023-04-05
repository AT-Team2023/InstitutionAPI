import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';

import '../CustomResponses/responseCustom.dart';

Middleware checkAuthorizationInstitution() => (innerHandler) => (Request req) {
      try {
        String? yourToken = req.headers['Authorization'].toString().trim();
        if (yourToken.isEmpty || yourToken == "Null") {
          throw FormatException(
              "Sorry, you do not have permissions or unauthorized");
        }
        bool hasExpired = JwtDecoder.isExpired(yourToken);
        if (hasExpired) {
          throw FormatException(
              "Sorry, you do not have permissions or unauthorized");
        }

        return innerHandler(req);
      } on FormatException catch (error) {
        switch (error.message) {
          case "Invalid payload":
            return ResponseCustom.unauthorizedResponse(
                message: "Sorry, you do not have permissions or unauthorized");
          case "Invalid token":
            return ResponseCustom.unauthorizedResponse(
                message: "Sorry, you do not have permissions or unauthorized");
          default:
            return ResponseCustom.unauthorizedResponse(message: error.message);
        }
      }
    };
