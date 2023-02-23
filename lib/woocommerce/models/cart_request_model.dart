class CartRequestModel {
  int userId;
  List<CartProducts>? products;

  CartRequestModel({
    required this.userId,
    required this.products,
  });

  factory CartRequestModel.fromJson(Map<String, dynamic> json) =>
      CartRequestModel(
        userId: json['user_id'],
        products: json['products'] != null
            ? List<CartProducts>.from(
                json['products'].map((index) => CartProducts.fromJson(index)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'products':
            products != null ? products!.map((e) => e.toJson()).toList() : null,
      };
}

class CartProducts {
  int productId;
  int quantity;

  CartProducts({
    required this.productId,
    required this.quantity,
  });

  factory CartProducts.fromJson(Map<String, dynamic> json) => CartProducts(
        productId: json['product_id'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'quantity': quantity,
      };
}
