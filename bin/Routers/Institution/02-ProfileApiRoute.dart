import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../Middlewares/checkAuthorizationInstitution.dart';
import '../../Responses/Institution/Auth/02-ConfirmCreateAccountInstitutionResponse.dart';
import '../../Responses/Institution/Contact/01-SetContactInstitutionResponse.dart';
import '../../Responses/Institution/Profile/01-GetProfileInstitutionResponse.dart';
import '../../Responses/Institution/Profile/02-UpdateProfileInstitutionResponse.dart';

class InstitutionProfileRoute {
  Handler get router {
    final router = Router();

    final pipeline = Pipeline()
        .addMiddleware(checkAuthorizationInstitution())
        .addHandler(router);

    router
      ..get('/get_profile/', getProfileInstitutionResponse)
      ..post('/update_profile/', updateProfileInstitutionResponse)
      ..post('/add_contact/', setContactInstitutionResponse);

    return pipeline;
  }
}
