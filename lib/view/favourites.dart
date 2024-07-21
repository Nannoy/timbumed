import 'package:flutter/material.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/widget/product_card.dart';

class Favorites extends StatelessWidget {
  final List<Product> favoriteItems;
  final Function(Product) toggleFavorite;
  final bool Function(Product) isFavorite;
  final Function(Product) addToCart;

  const Favorites({
    super.key,
    required this.favoriteItems,
    required this.toggleFavorite,
    required this.isFavorite,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(fontFamily: 'Poppins', fontSize: 15),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('No favorite items.'))
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: favoriteItems[index],
            toggleFavorite: toggleFavorite,
            isFavorite: isFavorite,
            addToCart: addToCart,
          );
        },
      ),
    );
  }
}
