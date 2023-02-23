// ignore_for_file: unnecessary_new

class LoginResponseModel {
  bool success;
  int statusCode;
  String code;
  String message;
  Data? data;

  LoginResponseModel({
    required this.success,
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json['success'],
        statusCode: json['statusCode'],
        code: json['code'],
        message: json['message'],
        data: json['data'].length > 0 ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'code': code,
        'message': message,
        'data': data != null ? data!.toJson() : null
      };
}

class Data {
  String token;
  int id;
  String email;
  String nicename;
  String firstName;
  String? lastName;
  String displayName;

  Data({
    required this.token,
    required this.id,
    required this.email,
    required this.nicename,
    required this.firstName,
    required this.lastName,
    required this.displayName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'],
        id: json['id'],
        email: json['email'],
        nicename: json['nicename'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        displayName: json['displayName'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'id': id,
        'email': email,
        'nicename': nicename,
        'firstName': firstName,
        'displayName': displayName,
      };
}
