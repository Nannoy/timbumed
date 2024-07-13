import 'package:flutter/material.dart';
import 'package:timbumed/model/cart_item.dart';
import 'package:timbumed/service/color.dart';
import 'package:timbumed/view/home.dart';
import 'package:timbumed/view/main.dart';

class Checkout extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const Checkout({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your purchase was successful!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(
                        'https://api.timbu.cloud/images/${cartItem.product
                            .imageUrl}',
                      ),
                      title: Text(cartItem.product.name),
                      subtitle: Text('₦ ${cartItem.product.price
                          .toStringAsFixed(2)} x ${cartItem.quantity}'),
                      trailing: Text('₦ ${(cartItem.product.price *
                          cartItem.quantity).toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
              // SizedBox(height: 16),
              // _buildPaymentMethodSection(),
              SizedBox(height: 16),
              _buildDeliveryAddressSection(),
              SizedBox(height: 16),
              _buildShippingMethodSection(),
              SizedBox(height: 16),
              _buildOrderSummarySection(),
              SizedBox(height: 16),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainView()
              ));
              _showSuccessDialog(context);
            },
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
              // Text(
              //   'Total: ₦ ${(totalAmount + 1500).toStringAsFixed(2)}', // Adjusted total amount
              //   style: const TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDeliveryAddressSection() {
    return Card(
      child: ListTile(
        title: Text('Albert Omoogun'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Murtala Street no.2'),
            Text('Abuja - FCT'),
            Text('+234 811-5235-400'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text('Edit'),
        ),
      ),
    );
  }

  Widget _buildShippingMethodSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
            'Enter your shipping address to view available shipping methods.'),
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildOrderSummaryRow(
                'Subtotal:', '₦ ${totalAmount.toStringAsFixed(2)}'),
            _buildOrderSummaryRow('Tax:', '₦ 500.00'),
            _buildOrderSummaryRow('Shipping:', '₦ 1,000.00'),
            Divider(),
            _buildOrderSummaryRow(
                'Total:', '₦ ${(totalAmount + 1500).toStringAsFixed(2)}',
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryRow(String label, String amount,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}