import 'package:flutter/material.dart';
import 'payment_page.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalAmount;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void continueToPayment() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final pincode = pincodeController.text.trim();

    if (name.isEmpty) {
      showError('Please enter your name');
      return;
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      showError('Name should contain only letters');
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      showError('Please enter a valid 10-digit phone number');
      return;
    }

    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      showError('Please enter a valid email address');
      return;
    }

    if (address.isEmpty) {
      showError('Please enter your delivery address');
      return;
    }

    if (city.isEmpty ||
        !RegExp(r'^[a-zA-Z ]+$').hasMatch(city)) {
      showError('Please enter a valid city name');
      return;
    }

    if (!RegExp(r'^[0-9]{6}$').hasMatch(pincode)) {
      showError('Please enter a valid 6-digit PIN code');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          cartItems: widget.cartItems,
          totalAmount: widget.totalAmount,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: inputDecoration(
                'Full Name',
                Icons.person,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: inputDecoration(
                '10-digit Phone Number',
                Icons.phone,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration(
                'Email Address',
                Icons.email,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: inputDecoration(
                'House No / Street / Area',
                Icons.home,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: cityController,
              decoration: inputDecoration(
                'City',
                Icons.location_city,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: inputDecoration(
                '6-digit PIN Code',
                Icons.pin_drop,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Your food will be delivered to this address.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: continueToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Continue to Payment',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}