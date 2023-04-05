import 'package:shelf/shelf.dart';

import '../Method/redirectWithTrailingSlash.dart';

Middleware middlewareRoot() => (innerHandler) => (Request request) async {
      if (!request.requestedUri.path.endsWith('/')) {
        return await innerHandler(
            await redirectWithTrailingSlash(request: request));
      }
      return innerHandler(request);
    };
