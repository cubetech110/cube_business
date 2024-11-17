import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Logo and Title
            Column(
              children: [
                Image.asset('assets/image/logo.png', height: 100), // Add a logo image asset
                const SizedBox(height: 10),
                const Text(
                  "Cube Store",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
              ],
            ),
            
            // Company Overview
            const Text(
              "Who We Are",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 0, 8)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Cube Store is an innovative e-commerce platform based in Oman, bringing local businesses online. Our mission is to empower Omani entrepreneurs by providing them with a streamlined platform to reach a wider audience. Through AI-driven tools and comprehensive features, Cube Store makes online business management simpler and more efficient for local businesses.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Mission
            const Text(
              "Our Mission",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 0, 8)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Our mission is to simplify digital access for Omani businesses, enhancing their potential to succeed in the online marketplace. By offering AI-powered tools and a user-friendly interface, we ensure that entrepreneurs can seamlessly manage their online presence and growth.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Vision
            const Text(
              "Our Vision",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 0, 5)),
            ),
            const SizedBox(height: 10),
            const Text(
              "To be Oman’s most trusted and innovative e-commerce platform, empowering local businesses through modern technology and tailored digital solutions.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Core Features
            const Text(
              "Core Features",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 0, 11)),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. AI-Powered Product Description Generator: Assists entrepreneurs in creating compelling product descriptions effortlessly.\n"
              "2. AI Chatbot for Users: Provides real-time support to enhance the shopping experience.\n"
              "3. Predictive AI Search: Helps users find relevant products faster.\n"
              "4. Multilingual Support: Available in both Arabic and English to cater to Omani users.\n"
              "5. Easy Order Management & Analytics Dashboard: Entrepreneurs can manage orders and track their performance with ease.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Contact Information
            const Text(
              "Contact Us",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 0, 7)),
            ),
            const SizedBox(height: 10),
            const Text(
              "For more information, feel free to reach out to our support team at support@cubestore.om.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 40),

            // Footer
            const Text(
              "© Cube Store 2024. All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
