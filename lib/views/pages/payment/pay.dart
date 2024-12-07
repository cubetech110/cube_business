import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/provider/user_provider.dart';
import 'package:cube_business/services/store_service.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Visa Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Card Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Card Number Field
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  hintText: "xxxx xxxx xxxx xxxx",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your card number";
                  } else if (value.length != 16) {
                    return "Card number must be 16 digits";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Expiry Date Field
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: "Expiry Date",
                  hintText: "MM/YY",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter expiry date";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // CVV Field
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: "CVV",
                  hintText: "XXX",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter CVV";
                  } else if (value.length != 3) {
                    return "CVV must be 3 digits";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Card Holder Name Field
              TextFormField(
                controller: _cardHolderController,
                decoration: InputDecoration(
                  labelText: "Card Holder Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter card holder name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              // Pay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {





                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Processing Payment...")),
                      );
                     await updateStoreField(userProvider.currentStore!.id!, 'aictived', true);

                      navigateAndRemove(context, HomeScreen());

                    }
                  },
                  child: Text("Pay Now"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> updateStoreField(String storeId, String field, dynamic value) async {
  try {
    await FirebaseFirestore.instance..collection('stores').doc(storeId).update({field: value});
    print('Store field updated successfully.');
  } catch (e) {
    print('Failed to update store field: $e');
  }
}

}
