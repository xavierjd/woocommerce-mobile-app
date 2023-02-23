import 'dart:convert';
import 'dart:io';

import 'package:woo_store/services/shared_services.dart';
import 'package:woo_store/woocommerce/api_config.dart';
import 'package:woo_store/woocommerce/models/cart_reponse_model.dart';
import 'package:woo_store/woocommerce/models/cart_request_model.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';
import 'package:woo_store/woocommerce/models/customer_detail_model.dart';
import 'package:woo_store/woocommerce/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:woo_store/woocommerce/models/login_model.dart';
import 'package:woo_store/woocommerce/models/order_details_model.dart';
import 'package:woo_store/woocommerce/models/order_model.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';

class ApiWoocommerce {
  Future<void> createCustomer(CustomerModel customer) async {
    final url = Uri.https(
      ApiConfig.url,
      ApiConfig.customersUrl,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${ApiConfig.key}:${ApiConfig.secret}',
      ),
    );
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
      },
      body: jsonEncode(customer.toJson()),
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
      ApiConfig.url,
      ApiConfig.tokenUrl,
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
      ApiConfig.url,
      ApiConfig.categoriesUrl,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${ApiConfig.key}:${ApiConfig.secret}',
      ),
    );
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
        HttpHeaders.contentTypeHeader: 'application/json',
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
    List<int>? productsIds,
    bool? featured,
    String? sortBy,
    String? sortOrder = 'desc',
  }) async {
    Map<String, dynamic> parameters = {};

    if (strSearch != null) {
      parameters['search'] = strSearch;
    }
    if (pageSize != null) {
      parameters['per_page'] = pageSize.toString();
    }
    if (pageNumber != null) {
      parameters['page'] = pageNumber.toString();
    }
    if (tagName != null) {
      parameters['tag'] = tagName;
    }
    if (categoryId != null) {
      parameters['category'] = categoryId.toString();
    }
    if (productsIds != null) {
      parameters['include'] = productsIds.join(",").toString();
    }
    if (featured != null) {
      parameters['featured'] = featured.toString();
    }
    if (sortBy != null) {
      parameters['orderby'] = sortBy;
    }
    if (sortOrder != null) {
      parameters['order'] = sortOrder;
    }

    final url = Uri.https(
      ApiConfig.url,
      ApiConfig.productsUrl,
      parameters,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${ApiConfig.key}:${ApiConfig.secret}',
      ),
    );
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
        HttpHeaders.contentTypeHeader: 'application/json',
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

  Future<CartResponseModel> addToCart({
    required CartRequestModel model,
  }) async {
    //model.userId = int.parse(ApiConfig.userId);

    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    if (loginResponseModel != null) {
      model.userId = loginResponseModel.data!.id;
    }

    final authToken =
        base64.encode(utf8.encode('${ApiConfig.key}:${ApiConfig.secret}'));
    final url = Uri.https(
      ApiConfig.url,
      ApiConfig.addToCartUrl,
    );
    final encoded = jsonEncode(model);
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: encoded,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CartResponseModel.fromJson(jsonData);
    }
    if (response.statusCode == 400) {
      throw response.statusCode;
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<CartResponseModel> getCartItems() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();

    if (loginResponseModel != null) {
      int userId = loginResponseModel.data!.id;

      final url = Uri.https(
        ApiConfig.url,
        ApiConfig.cartUrl,
        {'user_id': userId.toString()},
      );

      final authToken =
          base64.encode(utf8.encode('${ApiConfig.key}:${ApiConfig.secret}'));

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return CartResponseModel.fromJson(jsonData);
      }
      if (response.statusCode == 400) {
        throw response.statusCode;
      } else {
        throw 'Falló la conexión con el servidor';
      }
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<CustomerDetailsModel> customerDetails() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    if (loginResponseModel != null) {
      int userId = loginResponseModel.data!.id;

      final authToken =
          base64.encode(utf8.encode('${ApiConfig.key}:${ApiConfig.secret}'));
      final url = Uri.https(
        ApiConfig.url,
        '${ApiConfig.customersUrl}/${userId.toString()}',
      );
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return CustomerDetailsModel.fromJson(jsonData);
      }
      if (response.statusCode == 400) {
        throw response.statusCode;
      } else {
        throw 'Falló la conexión con el servidor';
      }
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<bool> createOrder(CreateOrderModel model) async {
    //model.customerId = int.parse(ApiConfig.userId);

    bool isOrderCreated = false;

    final url = Uri.https(
      ApiConfig.url,
      ApiConfig.orderUrl,
    );
    final authToken = base64.encode(
      utf8.encode(
        '${ApiConfig.key}:${ApiConfig.secret}',
      ),
    );
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 201) {
      return isOrderCreated = true;
    }
    if (response.statusCode == 400) {
      throw response.statusCode;
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<List<OrderModel>> getOrders() async {
    final url = Uri.https(
      ApiConfig.url,
      ApiConfig.orderUrl,
    );

    final authToken =
        base64.encode(utf8.encode('${ApiConfig.key}:${ApiConfig.secret}'));

    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData as List).map((e) => OrderModel.fromJson(e)).toList();
      //return CustomerDetailsModel.fromJson(jsonData);
    }
    if (response.statusCode == 400) {
      throw response.statusCode;
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }

  Future<OrderDetailsModel> getOrderDetails({
    required int orderId,
  }) async {
    final url = Uri.https(
      ApiConfig.url,
      '${ApiConfig.orderUrl}/${orderId.toString()}',
    );
    final authToken =
        base64.encode(utf8.encode('${ApiConfig.key}:${ApiConfig.secret}'));
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $authToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return OrderDetailsModel.fromJson(jsonData);
    } else {
      throw 'Falló la conexión con el servidor';
    }
  }
}
