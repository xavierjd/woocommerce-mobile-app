import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:woo_store/woocommerce/api_config.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';

class PaypalServices {
  String clientId =
      'AUN2nxlvU6KRzrjirRP-4hGIp1zO8WgVr61XOvVW17LtkaysYrY6sIlT9KBkRfRvHmq14ftSgCSCq5tt';
  String secret =
      'EM5aw7cmYdypj32PEFWF4sQKcDNgg360aagMTDodRNQnd6K2wbCeshIgG0WubNaOzJBq-E0pr3ZTnFZ6';

  String returnUrl = 'return.snippetcoder.com';
  String cancelUrl = 'cancel.snippetcoder.com';

  /*
   * Below Method is to generate the Accesstoken from Paypal
   */
  Future<String> getAccessToken() async {
    try {
      final url = Uri.https(
        ApiConfig.paypalUrl,
        '/v1/oauth2/token',
        {'grant_type': 'client_credentials'},
      );
      final authToken = base64.encode(
        utf8.encode('$clientId:$secret'),
      );
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['access_token'];
      } else {
        throw 'Falló la conexión con el servidor';
      }
    } catch (e) {
      rethrow;
    }
  }

  // you can change default currency according to you need
  Map<dynamic, dynamic> defaultCurrency = {
    'symbol': 'MXN',
    'decimalDigits': 2,
    'symbolBeforeTheNumber': true,
    'currency': 'MXN'
  };

  Map<String, dynamic> getOrderParams(BuildContext context) {
    var cartModel = Provider.of<CartProvider>(context, listen: false);
    cartModel.fetchCartItem();

    List items = [];
    for (var item in cartModel.getCartItems) {
      items.add({
        'name': item.productName,
        'quantity': item.qty,
        'price': item.productPrice,
        'currency': defaultCurrency['currency'],
      });
    }

    //Checkout invoice details
    String totalAmount = cartModel.totalAmount.toString();
    String subTotalAmount = cartModel.totalAmount.toString();
    String shippingCost = '0';
    int shippingDiscountCost = 0;

    Map<String, dynamic> temp = {
      'intent': 'sale',
      'payer': {'payment_method': 'paypal'},
      'transactions': [
        {
          'amount': {
            'total': totalAmount,
            'currency': defaultCurrency['currency'],
            'details': {
              'subtotal': subTotalAmount,
              'shipping': shippingCost,
              'shipping_discount': ((-1.0) * shippingDiscountCost).toString()
            }
          },
          'description': 'The payment transaction description.',
          'payment_options': {
            'allowed_payment_method': 'INSTANT_FUNDING_SOURCE'
          },
          'item_list': {
            'items': items,
          }
        }
      ],
      'note_to_payer': 'Contact us for any questions on your order.',
      'redirect_urls': {'return_url': returnUrl, 'cancel_url': cancelUrl}
    };
    return temp;
  }

/*
 * Below Method is use to Create Payment Request with Paypal
 */
  Future<Map<String, String>?> createPaypalPayment(
    transactions,
    accessToken,
  ) async {
    try {
      final url = Uri.https(
        ApiConfig.paypalUrl,
        '/v1/payments/payment',
      );
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(transactions),
      );
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (jsonData['links'] != null && jsonData['links'].length > 0) {
          List links = jsonData['links'];
          String executeUrl = '';
          String approvalUrl = '';
          final item = links.firstWhere(
              (element) => element['rel'] == 'approval_url',
              orElse: () => null);
          if (item != null) {
            approvalUrl = item['href'];
          }
          final item1 = links.firstWhere(
              (element) => element['rel'] == 'execute',
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1['href'];
          }
          return {'executeUrl': executeUrl, 'approvalUrl': approvalUrl};
        }
        return null;
      } else {
        throw Exception(jsonData['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  /*
   * Below method is use to executing Payment Transaction 
   */
  Future<String?> executePayment(
    Uri url,
    String payerId,
    String accessToken,
  ) async {
    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({'payer_id': payerId}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['id'];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
