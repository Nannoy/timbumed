import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/service/color.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final Function(Product) toggleFavorite;
  final bool Function(Product) isFavorite;
  final Function(Product) addToCart;

  const ProductDetails({
    super.key,
    required this.product,
    required this.toggleFavorite,
    required this.isFavorite,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.heart,
              color: isFavorite(product) ? Colors.red : Colors.black,
            ),
            onPressed: () => toggleFavorite(product),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Image.network(
                      'https://api.timbu.cloud/images/${product.imageUrl}',
                      height: 200, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
                'Multi Vitamin',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const Icon(Icons.star_half, color: Colors.yellow, size: 16),
                    const SizedBox(width: 5),
                    Text('(300 reviews)', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Text(
                  'Available in stock',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(product.description),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₦ ${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: (){
                    addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Iten Added to cart'),
                        duration: Duration(seconds: 2), // Duration for the Snackbar to be visible
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white,),
                            onPressed: () {},
                          ),
                          Text(
                              'Add to Cart',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
