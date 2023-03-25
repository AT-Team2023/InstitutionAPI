import 'dart:convert';

import 'package:regexed_validator/regexed_validator.dart';
import 'package:string_validator/string_validator.dart';

class ValidationClass {
  validateRequestBodyEmpty({required String? requestBody}) {
  print(requestBody?.length);
  if (requestBody!.isEmpty || requestBody.length <= 8) {
    throw const FormatException(
        "The body must contain the values as json <Key,value>");
  }
}

validateFoundKeyInJson(
    {required String? requestBody, required String keyName}) {
  final regex = RegExp('"$keyName"\\s*:\\s*');

  if (!regex.hasMatch(json.encode(jsonDecode(requestBody!)))) {
    throw FormatException('The body should has a key called \'$keyName\'');
  }
}

validatePassword({required String password}) {
  if (!validator.password(password) || password.length > 25) {
    throw FormatException(
        'please create a password that is between 8 and 25 characters long, and includes a combination of uppercase and lowercase letters, numbers, and symbols');
  }
}

validateEmail({required String email}) {
  if (!validator.email(email)) {
    throw FormatException(
        'Please ensure that you have entered a valid email correctly.');
  }
}

validateCode({required String code}) {
  if (!isNumeric(code)) {
    throw FormatException(
        'Please ensure that you have entered a valid code correctly.');
  }
}

validateID({required String id}) {
  if (!isUUID(id)) {
    throw FormatException(
        'Please ensure that you have entered a valid UUID correctly.');
  }
}
}