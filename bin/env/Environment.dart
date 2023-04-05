import 'dart:io';

class Environment {
  // Use any available host or container IP (usually `0.0.0.0`).

  static final ip = InternetAddress.anyIPv4;
  static final port = int.parse(Platform.environment['PORT'] ?? '8080');
}
