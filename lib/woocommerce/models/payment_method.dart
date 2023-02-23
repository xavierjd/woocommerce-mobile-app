class PaymentMehod {
  String id;
  String name;
  String description;
  String logo;
  String route;
  Function onTap;
  bool isRouteRedirect;

  PaymentMehod({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.route,
    required this.onTap,
    required this.isRouteRedirect,
  });
}

class PaymentMethodList {
  List<PaymentMehod> _paymentsList = [];
  List<PaymentMehod> _cashList = [];

  PaymentMethodList() {
    _paymentsList = [
      PaymentMehod(
        id: "stripe",
        name: "Stripe",
        description: "Click to pay with Stripe",
        logo: "assets/img/mercado_pago_bitfun.png",
        route: "stripe",
        onTap: () {},
        isRouteRedirect: false,
      ),
      PaymentMehod(
        id: "paypal",
        name: "PayPal",
        description: "Click to pay with Paypal",
        logo: "assets/img/paypal_bitfun.png",
        route: "paypal",
        onTap: () {},
        isRouteRedirect: true,
      ),
    ];
    _cashList = [
      PaymentMehod(
        id: "cod",
        name: "Cash on Delivery",
        description: "Click to pay cash on delivery",
        logo: "assets/img/carnet.png",
        route: "/OrderSuccess",
        onTap: () {},
        isRouteRedirect: false,
      ),
    ];
  }

  List<PaymentMehod> get paymentsList => _paymentsList;
  List<PaymentMehod> get cashList => _cashList;
}
