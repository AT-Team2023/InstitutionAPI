import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Institution/01-AuthApiRoute.dart';
import 'Institution/02-ProfileApiRoute.dart';

class BaseApiRoute {
  Handler get router {
    final router = Router()
      ..mount('/institution/auth/', InstitutionAuthRoute().router)
      ..mount('/institution/profile/', InstitutionProfileRoute().router);

    return router;
  }
}
