import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String id;
  String username;
  String email;
  String fcm;
  String password;
  bool verification;
  String phone;
  bool phoneVerification;
  String userType;
  String profile;
  String userToken;

  LoginResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.fcm,
    required this.password,
    required this.verification,
    required this.phone,
    required this.phoneVerification,
    required this.userType,
    required this.profile,
    required this.userToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        fcm: json["fcm"] ?? "",
        password: json["password"] ?? "",
        verification: json["verification"] ?? false,
        phone: json["phone"] ?? "",
        phoneVerification: json["phoneVerification"] ?? false,
        userType: json["userType"] ?? "",
        profile: json["profile"] ?? "",
        userToken: json["userToken"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "fcm": fcm,
        "password": password,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "profile": profile,
        "userToken": userToken,
      };
}
