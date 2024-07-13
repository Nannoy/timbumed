class Product {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double rating;
  final double weight;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.weight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Get the image URL from the first photo in the array, if it exists
    final photos = json['photos'] as List<dynamic>?;
    final imageUrl = photos != null && photos.isNotEmpty
        ? photos[0]['url'] as String? ?? ''
        : '';

    // Extract price from the current_price field
    final currentPrice = json['current_price'] as List<dynamic>?;
    final price = currentPrice != null && currentPrice.isNotEmpty
        ? (currentPrice[0]['NGN'] as List<dynamic>?)![0] as double? ?? 0.0
        : 0.0;

    return Product(
      imageUrl: imageUrl,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: price,
      rating: 0.0, // You might need to add this field if available
      weight: 0.0, // You might need to add this field if available
    );
  }
}
