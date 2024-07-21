import 'package:flutter/material.dart';
import 'package:timbumed/model/cart_item.dart';
import 'package:timbumed/service/color.dart';
import 'package:timbumed/view/checkout.dart';

class Cart extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(CartItem, int) updateQuantity;
  final Function(CartItem) removeFromCart;

  const Cart({
    super.key,
    required this.cartItems,
    required this.updateQuantity,
    required this.removeFromCart,
  });

  double get totalAmount {
    return cartItems.fold(
        0.0, (sum, item) => sum + item.product.price * item.quantity);
  }

  Map<String, Map<String, dynamic>> _groupCartItemsByVendor(List<CartItem> cartItems) {
    Map<String, Map<String, dynamic>> groupedItems = {};

    for (var item in cartItems) {
      if (!groupedItems.containsKey(item.product.vendor)) {
        groupedItems[item.product.vendor] = {
          'items': <CartItem>[],
          'quantity': 0
        };
      }
      groupedItems[item.product.vendor]!['items'].add(item);
      groupedItems[item.product.vendor]!['quantity'] += item.quantity;
    }

    return groupedItems;
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = _groupCartItemsByVendor(cartItems);

    return Scaffold(
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
        children: [
          Expanded(
            child: ListView(
              children: groupedItems.entries.map((entry) {
                final vendorName = entry.key;
                final items = entry.value['items'] as List<CartItem>;
                final quantity = entry.value['quantity'] as int;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '$vendorName ($quantity)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...items.map((cartItem) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SizedBox(
                                          height: 60,
                                            width: 60,
                                            child: Image.network('https://api.timbu.cloud/images/${cartItem.product.imageUrl}',)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cartItem.product.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                                      Text(cartItem.product.category, style: const TextStyle(color: Colors.grey, fontSize: 10),),
                                      Text('₦ ${cartItem.product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontSize: 20),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove, size: 13,),
                                        onPressed: () => updateQuantity(
                                            cartItem, cartItem.quantity - 1),
                                      ),
                                      Text(cartItem.quantity.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add, size: 13,),
                                        onPressed: () => updateQuantity(
                                            cartItem, cartItem.quantity + 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.favorite_border, size: 15,),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () => removeFromCart(cartItem),
                                          ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                      //   Card(
                      //   margin: const EdgeInsets.all(8.0),
                      //   child: ListTile(
                      //     leading: Image.network(
                      //       'https://api.timbu.cloud/images/${cartItem.product.imageUrl}',
                      //     ),
                      //     title: Text(cartItem.product.name),
                      //     subtitle: Text(
                      //         '₦ ${cartItem.product.price.toStringAsFixed(2)}'),
                      //     trailing: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         IconButton(
                      //           icon: const Icon(Icons.remove),
                      //           onPressed: () => updateQuantity(
                      //               cartItem, cartItem.quantity - 1),
                      //         ),
                      //         Text(cartItem.quantity.toString()),
                      //         IconButton(
                      //           icon: const Icon(Icons.add),
                      //           onPressed: () => updateQuantity(
                      //               cartItem, cartItem.quantity + 1),
                      //         ),
                      //         IconButton(
                      //           icon: const Icon(Icons.delete),
                      //           onPressed: () => removeFromCart(cartItem),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    }),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text(
                //   'Total: ₦ ${totalAmount.toStringAsFixed(2)}',
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Checkout(
                            cartItems: cartItems,
                            totalAmount: totalAmount),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
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
