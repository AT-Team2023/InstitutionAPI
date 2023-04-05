import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../Responses/Institution/Auth/01-ConfirmCreateAccountInstitutionResponse.dart';
import '../../Responses/Institution/Auth/02-ConfirmCreateAccountInstitutionResponse.dart';
import '../../Responses/Institution/Auth/03-LoginAccountInstitutionResponse.dart';
import '../../Responses/Institution/Auth/04-RestPasswordAccountInstitutionResponse.dart';
import '../../Responses/Institution/Auth/05-ConfirmRestAccountInstitutionResponse.dart';
import '../../Responses/Institution/Auth/06-UpdatePasswordAccountInstitutionResponse.dart';
import '../../Responses/Institution/Auth/07-GetCodeConfirmAccountInstitutionResponse.dart';

class InstitutionAuthRoute {
  Handler get router {
    final router = Router();

    router
      ..post('/create_account/', createAccountInstitutionResponse)
      ..post('/confirm_create/', confirmCreateAccountInstitutionResponse)
      ..post('/login/', loginAccountInstitutionResponse)
      ..post('/rest_password/', restPasswordAccountInstitutionResponse)
      ..post('/confirm_rest/', confirmRestAccountInstitutionResponse)
      ..post('/update_password/', updatePasswordAccountInstitutionResponse)
      ..post('/get_code_signup/', GetCodeConfirmAccountInstitutionResponse);

    return router;
  }
}
