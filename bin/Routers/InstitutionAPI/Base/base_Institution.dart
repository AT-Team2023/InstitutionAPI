
import 'package:shelf_router/shelf_router.dart';

import '../Response/Auth/Confirm_Institution.dart';
import '../Response/Auth/Create_Account_Institution.dart';
import '../Response/Auth/Login_Institution.dart';
import '../Response/Auth/Rest_Password_Institution.dart';
import '../Response/Auth/Confirm_Rest_Password_Institution.dart';
import '../Response/Auth/Update_Password_Institution.dart';

class InstitutionRouter {
  Router get router {
    final _router = Router()
      //Auth
      ..post('/auth/create_account/', CreateAccountInstitution().router)
      ..post('/auth/confirm/', ConfirmInstitution().router)
      ..post('/auth/login/', LoginInstitution().router)
      ..post('/auth/rest_password/', RestPasswordInstitution().router)
      ..post(
          '/auth/confirm_rest_password/', ConfirmPasswordInstitution().router)
      ..post('/auth/update_password/', UpdatePasswordInstitution().router);

    return _router;
  }
}
