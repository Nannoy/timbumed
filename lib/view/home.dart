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
  String selectedCategory = 'All'; // State variable for the selected category
  final List<String> categories = [
    'All',
    'Vitamins',
    'Antibiotics'
  ]; // List of categories

  @override
  void initState() {
    super.initState();
    _futureProducts = ApiService().fetchProducts();
  }

  List<Product> _filterProducts(List<Product> products) {
    if (selectedCategory == 'All') {
      return products;
    } else {
      return products.where((product) => product.category == selectedCategory)
          .toList();
    }
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
                  SizedBox(
                    height: 35,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for products...',
                        hintStyle: const TextStyle(color: Colors.grey,
                            fontSize: 10,
                            fontFamily: 'Poppins'),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.search, color: Colors.grey,
                          size: 10,),
                        suffixIcon: IconButton(
                          icon: const Icon(FontAwesomeIcons.filter,
                            color: Colors.grey, size: 10,),
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
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      DropdownButton<String>(
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                            _futureProducts = ApiService()
                                .fetchProducts(); // Re-fetch products to apply the new filter
                          });
                        },
                        items: categories.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.primaryColor.withOpacity(0.3),
                        ),
                        child: IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.tableCellsLarge, size: 15,),
                          onPressed: () {},
                        ),
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.bars, size: 15,),
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
                    child: Center(child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 0.8,
                        color: AppColor.primaryColor,
                      ),
                    )),
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
                  final products = _filterProducts(snapshot.data!);
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