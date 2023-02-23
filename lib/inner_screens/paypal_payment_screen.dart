import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/inner_screens/order_success_screen.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/order_model.dart';
import 'package:woo_store/woocommerce/provider/order_provider.dart';
import 'package:woo_store/woocommerce/provider/paypal_services.dart';

class PaypalPaymentScreen extends StatefulWidget {
  static const routeName = 'paypal';
  const PaypalPaymentScreen({super.key});

  @override
  State<PaypalPaymentScreen> createState() => _PaypalPaymentScreenState();
}

class _PaypalPaymentScreenState extends State<PaypalPaymentScreen> {
  late InAppWebViewController webView;
  String url = '';
  double progressBar = 0;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;

  late PaypalServices paypalServices;

  @override
  void initState() {
    super.initState();
    paypalServices = PaypalServices();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await paypalServices.getAccessToken();
        final transactions = paypalServices.getOrderParams(context);
        final res =
            await paypalServices.createPaypalPayment(transactions, accessToken);

        if (res != null) {
          setState(() {
            checkoutUrl = res['approvalUrl'];
            executeUrl = res['executeUrl'];
          });
        }
      } catch (e) {
        print('Exception: ' + e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'PayPal Payment',
            color: Colors.white,
            textSize: 18,
            isTitle: true,
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(checkoutUrl!),
              ),
              onWebViewCreated: ((controller) {
                webView = controller;
              }),
              onLoadStart: (controller, requestUrl) async {
                // Here handling of success/error
                String request = requestUrl.toString();
                if (request.contains(paypalServices.returnUrl)) {
                  //final uri = Uri.parse(request);
                  final payerId = requestUrl!.queryParameters['PayerID'];
                  if (payerId != null) {
                    final id = await paypalServices.executePayment(
                        Uri.parse(executeUrl!), payerId, accessToken!);

                    if (id != null) {
                      //print('Success: ' + id.toString());
                      final createOrderProvider =
                          Provider.of<OrderProvider>(context, listen: false);

                      createOrderProvider.processOrder(
                        CreateOrderModel(
                          customerId: 1,
                          paymentMethod: 'paypal',
                          paymentMethodTitle: 'Paypal',
                          setPaid: true,
                          transactionId: id.toString(),
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        OrderSuccessScreen.routeName,
                        (Route<dynamic> route) => false,
                      );
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                }
                if (request.contains(paypalServices.cancelUrl)) {
                  Navigator.of(context).pop();
                }
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  progressBar = progress / 100;
                });
              },
            ),
            progressBar < 1
                ? SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      value: progressBar,
                      backgroundColor: Colors.redAccent.withOpacity(0.8),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'PayPal Payment',
            color: Colors.white,
            textSize: 18,
            isTitle: true,
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
