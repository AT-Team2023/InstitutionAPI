import 'package:shelf/shelf.dart';

Future<Request> redirectWithTrailingSlash({required Request request}) async {
  final newPath = '${request.requestedUri.path}/';
  final uri = request.requestedUri.replace(path: newPath);
  final modifiedRequest = Request(
    request.method,
    uri,
    body: await request.readAsString(),
    headers: request.headers,
  );
  return modifiedRequest;
}

