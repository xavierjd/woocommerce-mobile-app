import 'package:collection/collection.dart';

class CustomerDetailsModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String avatarUrl;
  Meta profilePicture;
  Billing? billing;
  Shipping? shipping;

  CustomerDetailsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
    required this.profilePicture,
    required this.billing,
    required this.shipping,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailsModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        avatarUrl: json['avatar_url'],
        profilePicture: List<Meta>.from(
                json["meta_data"].map((element) => Meta.fromJson(element)))
            .firstWhere((element) => element.key == 'bf_profile_picture'),
        billing:
            json['billing'] != null ? Billing.fromJson(json['billing']) : null,
        shipping: json['shipping'] != null
            ? Shipping.fromJson(json['shipping'])
            : null,
      );
}

class Billing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.email,
    required this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        firstName: json['first_name'],
        lastName: json['last_name'],
        company: json['company'],
        address1: json['address_1'],
        address2: json['address_2'],
        city: json['city'],
        postcode: json['postcode'],
        country: json['country'],
        state: json['state'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'company': company,
        'address_1': address1,
        'address_2': address2,
        'city': city,
        'postcode': postcode,
        'country': country,
        'state': state,
        'email': email,
        'phone': phone,
      };
}

class Shipping {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;

  Shipping({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        firstName: json['first_name'],
        lastName: json['last_name'],
        company: json['company'],
        address1: json['address_1'],
        address2: json['address_2'],
        city: json['city'],
        postcode: json['postcode'],
        country: json['country'],
        state: json['state'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'company': company,
        'address_1': address1,
        'address_2': address2,
        'city': city,
        'postcode': postcode,
        'country': country,
        'state': state,
      };
}

class Meta {
  String key;
  dynamic value;

  Meta({
    required this.key,
    required this.value,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        key: json['key'],
        value: json['value'],
      );
}
