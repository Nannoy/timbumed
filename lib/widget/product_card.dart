import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/view/product_details.dart';
import 'package:timbumed/widget/rating.dart';

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
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Image.network(
                          'https://api.timbu.cloud/images/${product.imageUrl}',
                          height: 50, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        size: 13,
                        color: isFavorite(product) ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        toggleFavorite(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item Added to favorites'),
                            duration: Duration(seconds: 2), // Duration for the Snackbar to be visible
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10),),
              Row(
                children: [
                  Text(product.category, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  const SizedBox(width: 5),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('${product.grams} grams', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
                      )),
                ],
              ),
              Row(
                children: [
                  StarRating(rating: product.rating),
                  const SizedBox(width: 5),
                  Text('(${product.rating} ratings)', style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₦ ${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.black, size: 10,),
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
