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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            'https://api.timbu.cloud/images/${cartItem.product.imageUrl}',
                          ),
                          title: Text(cartItem.product.name),
                          subtitle: Text(
                              '₦ ${cartItem.product.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => updateQuantity(
                                    cartItem, cartItem.quantity - 1),
                              ),
                              Text(cartItem.quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => updateQuantity(
                                    cartItem, cartItem.quantity + 1),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => removeFromCart(cartItem),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: ₦ ${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: (){
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
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                  'Proceed to Checkout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"
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
