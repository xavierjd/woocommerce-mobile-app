import 'dart:convert';
import 'dart:io';

import 'package:woo_store/woocommerce/config.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';
import 'package:woo_store/woocommerce/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:woo_store/woocommerce/models/login_model.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';

class ApiWoocommerce {
  Future listOrders() async {
    final authToken =
        base64.encode(utf8.encode('${Config.key}:${Config.secret}'));
    final url = Uri.https(
      Config.url,
      '/wp-json/wc/v3/orders',
      {'status': 'on-hold'},
    );

    bool ret = false;
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      },
    );

    if (response.statusCode == 200) {
      ret = true;
    } else {
      ret = false;
    }
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    return ret;
  }

  Future<void> createCustomer(CustomerModel customer) async {
    final url = Uri.https(
      Config.url,
      Config.customersUrl,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${Config.key}:${Config.secret}',
      ),
    );
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      },
      body: customer.toJson(),
    );
    if (response.statusCode == 400) {
      throw 'Este correo electrónico ya está registrado 😕';
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<LoginResponseModel> loginCustomer({
    required String username,
    required String password,
  }) async {
    final url = Uri.https(
      Config.url,
      Config.tokenUrl,
    );

    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      },
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return LoginResponseModel.fromJson(jsonData);
    }
    if (response.statusCode == 403) {
      throw 'Correo electrónico y/o contraseña incorrecto';
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    final url = Uri.https(
      Config.url,
      Config.categoriesUrl,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${Config.key}:${Config.secret}',
      ),
    );
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData as List)
          .map(
            (index) => CategoryModel.fromJson(index),
          )
          .toList();
    }
    if (response.statusCode == 403) {
      throw 'error data';
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<List<ProductModel>> getProducts({
    int? pageNumber,
    int? pageSize,
    String? strSearch,
    String? tagName,
    String? categoryId,
    String? sortBy,
    String sortOrder = 'asc',
  }) async {
    Map<String, dynamic> parameters = {};

    if (strSearch != null) {
      parameters['search'] = strSearch;
    }
    if (pageSize != null) {
      parameters['per_page'] = pageSize;
    }
    if (pageNumber != null) {
      parameters['page'] = pageNumber;
    }
    if (tagName != null) {
      parameters['tag'] = tagName;
    }
    if (categoryId != null) {
      parameters['category'] = categoryId;
    }
    if (sortBy != null) {
      parameters['orderby'] = sortBy;
    }
    parameters['order'] = sortOrder;

    final url = Uri.https(
      Config.url,
      Config.productsUrl,
      parameters,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${Config.key}:${Config.secret}',
      ),
    );
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData as List)
          .map(
            (index) => ProductModel.fromJson(index),
          )
          .toList();
    }
    if (response.statusCode == 403) {
      throw 'error data';
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }
}
