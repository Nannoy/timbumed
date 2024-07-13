import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timbumed/model/product.dart';
import '../config/config.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final config = Config();
    await config.load();

    final url = Uri.parse('${config.baseUrl}/products?organization_id=${config.organizationId}&Appid=${config.appId}&Apikey=${config.apiKey}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> items = jsonResponse['items']; // Assuming 'items' contains the list of products

      return items.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
