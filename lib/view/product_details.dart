import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/service/color.dart';
import 'package:timbumed/widget/rating.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: MediaQuery.of(context).size.height * 0.05
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                            child: Container(
                              height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primaryColor,
                                ),
                                child: const Center(child: Icon(Icons.arrow_back_ios, size: 13, color: Colors.white,))),
                          )),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.bagShopping,
                                    size: 12,
                                    color: Colors.black,
                                  ), onPressed: () {},
                                ),),
                          )),
                    ],
                  ),
                  Center(
                    child: Image.network(
                        'https://api.timbu.cloud/images/${product.imageUrl}',
                        height: 130,
                        fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    icon: const FaIcon(
                                      FontAwesomeIcons.heart,
                                      size: 12,
                                      color: AppColor.primaryColor,
                                    ), onPressed: () {},
                                  ),),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(
                  product.category,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        StarRating(rating: product.rating),
                        const SizedBox(width: 5),
                        Text('(${product.review} reviews)', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    Text(
                      '${product.availableQuantity.toInt()} pieces available in stock',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(product.description),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Price', style: TextStyle(color: Colors.grey, fontSize: 10),),
                    Text('₦ ${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold,)),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item Added to cart'),
                        duration: Duration(seconds: 2), // Duration for the Snackbar to be visible
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white, size: 10,),
                            onPressed: () {},
                          ),
                          const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 12),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
