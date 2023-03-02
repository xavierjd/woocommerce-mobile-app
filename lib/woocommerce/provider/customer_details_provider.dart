import 'package:flutter/material.dart';
import 'package:woo_store/woocommerce/models/customer_detail_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class CustomerDetailsProvider with ChangeNotifier {
  CustomerDetailsModel? _customerDetailsModel;

  CustomerDetailsModel? get getCustomerDetailsModel => _customerDetailsModel;

  Future<void> fetchShippingDetails() async {
    _customerDetailsModel = await apiWoocommerce.customerDetails();
    notifyListeners();
  }
}
