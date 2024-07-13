import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/service/api_service.dart';
import 'package:timbumed/service/color.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/widget/product_card.dart';

class Home extends StatefulWidget {
  final Function(Product) toggleFavorite;
  final bool Function(Product) isFavorite;
  final Function(Product) addToCart;

  const Home({
    super.key,
    required this.toggleFavorite,
    required this.isFavorite,
    required this.addToCart,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for products...',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Poppins'),
                      prefixIcon: const Icon(FontAwesomeIcons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(FontAwesomeIcons.filter, color: Colors.grey),
                        onPressed: () {
                          // Add your filter action here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Vitamins',
                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withOpacity(0.3),
                        ),
                        child: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.tableCellsLarge),
                          onPressed: () {},
                        ),
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.bars),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Product>>(
              future: _futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No products found')),
                  );
                } else {
                  final products = snapshot.data!;
                  return SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (ctx, index) {
                          return ProductCard(
                            product: products[index],
                            toggleFavorite: widget.toggleFavorite,
                            isFavorite: widget.isFavorite,
                            addToCart: widget.addToCart,
                          );
                        },
                        childCount: products.length,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
