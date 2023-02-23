import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/Utils/checkpoints_widget.dart';
import 'package:woo_store/Utils/form_helper.dart';
import 'package:woo_store/inner_screens/payment_screen.dart';

import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/customer_detail_model.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';
import 'package:woo_store/woocommerce/provider/customer_details_provider.dart';

class VerifyAddressScreen extends StatefulWidget {
  static const routeName = 'verifyAddress';
  const VerifyAddressScreen({super.key});

  @override
  State<VerifyAddressScreen> createState() => _VerifyAddressScreenState();
}

class _VerifyAddressScreenState extends State<VerifyAddressScreen> {
  int currentPage = 0;
  List<String> checkPoints = [
    'Shipping',
    'Payment',
    'Order',
  ];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 1), () async {
      final customerDetailsProvider =
          Provider.of<CustomerDetailsProvider>(context, listen: false);
      await customerDetailsProvider.fetchShippingDetails();
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerDetailsProvider =
        Provider.of<CustomerDetailsProvider>(context);
    final customerModel = customerDetailsProvider.getCustomerDeatilsModel;

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Verify Address',
        backgroundColor: Colors.pinkAccent,
      ),
      body: LoadingWidget(
        isLoading: _isLoading,
        child: customerModel == null
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CheckPoints(
                      checkedTill: currentPage,
                      checkPoints: checkPoints,
                      checkPointFilledColor: Colors.green,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    _formUI(customerModel),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _formUI(CustomerDetailsModel? data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextWidget(
                      text: 'First Name',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextWidget(
                      text: 'Last Name',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabelValue(
                        context: context, labelName: data!.firstName),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormHelper.fieldLabelValue(
                          context: context, labelName: data.lastName),
                    ),
                  ),
                ],
              ),
              TextWidget(
                text: 'Address',
                color: Colors.black,
                textSize: 18,
                isTitle: true,
              ),
              FormHelper.fieldLabelValue(
                context: context,
                labelName: data.shipping!.address1,
              ),
              TextWidget(
                text: 'Apartment, suite, etc.',
                color: Colors.black,
                textSize: 18,
                isTitle: true,
              ),
              FormHelper.fieldLabelValue(
                context: context,
                labelName: data.shipping!.address2,
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextWidget(
                      text: 'City',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextWidget(
                      text: 'Postcode',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabelValue(
                        context: context, labelName: data.shipping!.city),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormHelper.fieldLabelValue(
                          context: context, labelName: data.shipping!.postcode),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextWidget(
                      text: 'State',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextWidget(
                      text: 'Country',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabelValue(
                        context: context, labelName: data.shipping!.state),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormHelper.fieldLabelValue(
                          context: context, labelName: data.shipping!.country),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: FormHelper.saveButton(
                  "Next",
                  () {
                    Navigator.pushNamed(
                      context,
                      PaymentScreen.routeName,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
