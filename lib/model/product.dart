import 'dart:convert';

class Product {
  final String imageUrl;
  final String name;
  final String category;
  final String description;
  final double price;
  final double rating;
  final double grams;
  final int review;
  final String vendor;
  final double availableQuantity;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.grams,
    required this.review,
    required this.category,
    required this.vendor,
    required this.availableQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Get the image URL from the first photo in the array, if it exists
    final photos = json['photos'] as List<dynamic>?;
    final imageUrl = photos != null && photos.isNotEmpty
        ? photos[0]['url'] as String? ?? ''
        : '';

    // Get the category
    // final category = json['categories'] as List<dynamic>?;
    // final productCategory = category != null && category.isNotEmpty
    //     ? category[0]['name'] as String? ?? 'not specified'
    //     : 'not specified';

    // Parse the description string as JSON and extract product_description and product_rating
    final descriptionStr = json['description'] as String? ?? '[]';
    final descriptionList = jsonDecode(descriptionStr) as List<dynamic>;

    // Extracting values from descriptionList
    final productDescription = descriptionList.isNotEmpty
        ? descriptionList[0]['product_description'] as String? ?? ''
        : 'Not Specified';
    final productRating = descriptionList.isNotEmpty
        ? descriptionList[0]['product_rating'] as double? ?? 0.0
        : 0.0;
    final productGrams = descriptionList.isNotEmpty
        ? descriptionList[0]['grams'] as double? ?? 0.0
        : 0.0;
    final productReview = descriptionList.isNotEmpty
        ? descriptionList[0]['reviews'] as int? ?? 0.0
        : 0.0;
    final productVendor = descriptionList.isNotEmpty
        ? descriptionList[0]['vendor'] as String? ?? ''
        : 'Not Specified';
    final productCategory = descriptionList.isNotEmpty
        ? descriptionList[0]['category'] as String? ?? ''
        : 'Not Specified';

    // Extract price from the current_price field
    final currentPrice = json['current_price'] as List<dynamic>?;
    final price = currentPrice != null && currentPrice.isNotEmpty
        ? (currentPrice[0]['NGN'] as List<dynamic>?)![0] as double? ?? 0.0
        : 0.0;

    return Product(
      imageUrl: imageUrl,
      name: json['name'] as String? ?? '',
      description: productDescription,
      price: price,
      rating: productRating,
      grams: productGrams,
      review: productReview.toInt(),
      category: productCategory,
      vendor: productVendor,
      availableQuantity: json['available_quantity'],
    );
  }
}
