import 'package:supabase/supabase.dart';

class InstitutionModelSignUp {
  String? id;
  String? name;
  String? description;
  DateTime? dataEstablishment;
  String email;
  String password;
  String? phoneNumber;
  DateTime? createAt;
  bool? verified;
  StatusInstitution? status;
  InstitutionModelSignUp(
      {required this.email,
      required this.password,
      this.phoneNumber,
      this.createAt,
      this.dataEstablishment,
      this.description,
      this.id,
      this.name,
      this.status,
      this.verified});

  factory InstitutionModelSignUp.fromJson(Map<String, dynamic> json) {
    return InstitutionModelSignUp(
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        createAt: json['createAt'],
        dataEstablishment: json['dataEstablishment'],
        description: json['description'],
        id: json['id'],
        name: json['name'],
        status: json['status'],
        verified: json['verified']);
  }

  toMap() {
    return {
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'createAt': createAt,
      'dataEstablishment': dataEstablishment,
      'description': description,
      'id': id,
      'name': name,
      'status': status,
      'verified': verified
    };
  }
}

enum StatusInstitution {
  request,
  processing,
  rejected,
  activated,
  suspended,
  blacked
}
