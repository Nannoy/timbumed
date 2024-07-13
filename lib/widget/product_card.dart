import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/view/product_details.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) toggleFavorite;
  final bool Function(Product) isFavorite;
  final Function(Product) addToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.toggleFavorite,
    required this.isFavorite,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: product,
              toggleFavorite: toggleFavorite,
              isFavorite: isFavorite,
              addToCart: addToCart,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Image.network(
                        'https://api.timbu.cloud/images/${product.imageUrl}',
                        height: 80, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color: isFavorite(product) ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        toggleFavorite(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item Added to favorites'),
                            duration: Duration(seconds: 2), // Duration for the Snackbar to be visible
                          ),
                        );
                        },
                    ),
                  ),
                ],
              ),
              Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  const Text('Niacin', style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 5),
                  Text('${product.weight} grams', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const Icon(Icons.star_half, color: Colors.yellow, size: 16),
                  const SizedBox(width: 5),
                  Text('(${product.rating} ratings)', style: const TextStyle(color: Colors.grey)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₦ ${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.black),
                    onPressed: () => addToCart(product),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
