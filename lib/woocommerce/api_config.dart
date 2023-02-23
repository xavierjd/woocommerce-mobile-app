class ApiConfig {
  static String key = 'ck_e7a1d4540a8bf3200b30ca509c61260210061850';
  static String secret = 'cs_e723e12187a6862be17690abc7c7bc86b43ad1cc';
  static String url = 'bitfun.mx';
  static String tokenUrl = '/wp-json/jwt-auth/v1/token';
  static String customersUrl = '/wp-json/wc/v3/customers';
  static String categoriesUrl = '/wp-json/wc/v3/products/categories';
  static String productsUrl = "/wp-json/wc/v3/products";
  static String addToCartUrl = "/wp-json/wc/v3/addtocart";
  static String cartUrl = "/wp-json/wc/v3/cart";
  static String orderUrl = "/wp-json/wc/v3/orders";
  //static String userId = "1";

  static String paypalClientID = '';
  static String paypalSecret = '';
  static String paypalUrl = 'api.sandbox.paypal.com'; //for sandbox mode
  //static String paypalUrl = 'https://api.paypal.com'; //for Production mode
}
