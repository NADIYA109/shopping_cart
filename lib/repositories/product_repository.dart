import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts({int limit = 10, int skip = 0}) async {
    final response = await http.get(Uri.parse("$apiUrl?limit=$limit&skip=$skip"));

    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }
}
