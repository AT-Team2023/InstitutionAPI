import 'package:shelf_router/shelf_router.dart';
import '../../Routers/InstitutionAPI/Base/base_Institution.dart';
import '../Response/notFoundRoute.dart';

class BaseRouter {
  Router get router {
    final _router = Router()
      ..mount('/institution/', InstitutionRouter().router)
      ..all("/<name|.*>/", RouteNotFound().router);

    return _router;
  }
}
