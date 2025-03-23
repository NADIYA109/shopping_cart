import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str)["products"].map((x) => Product.fromJson(x)));

class Product {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final String? brand;
  int? quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    this.brand,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
      discountPercentage: json["discountPercentage"].toDouble(),
      thumbnail: json["thumbnail"],
      brand: json["brand"],

    );
  }

  double get finalPrice => price * (1 - discountPercentage / 100);

  String get formattedPrice =>
      "₹${price.toStringAsFixed(2)}  ₹${finalPrice.toStringAsFixed(2)} (${discountPercentage.toStringAsFixed(2)}% OFF)";
}



