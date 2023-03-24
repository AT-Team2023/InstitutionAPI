import 'package:shelf_router/shelf_router.dart';
import '../../Routers/InstitutionAPI/Router-EndPoint/root_Institution_Router.dart';
import '../Response/notFoundRoute.dart';

class BaseRouter {
  Router get router {
    final _router = Router()
      ..mount('/institution/', InstitutionRouter().router)
      ..all("/<name|.*>/", RouteNotFound().router);

    return _router;
  }
}
