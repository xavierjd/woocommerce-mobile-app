class CustomerModel {
  String email;
  String firstName;
  String lastName;
  String password;

  CustomerModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'userName': email,
      };
}
