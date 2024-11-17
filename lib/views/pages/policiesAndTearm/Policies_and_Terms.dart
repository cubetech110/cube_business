import 'package:flutter/material.dart';

class PoliciesAndTermsPage extends StatelessWidget {
  const PoliciesAndTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Policies and Terms"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Privacy Policy Section
            const Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Cube Store values your privacy. We collect minimal information necessary to improve your experience on our platform. We ensure that your data is handled securely and only shared when essential to fulfill services. Your data will not be sold to third parties.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Terms of Use Section
            const Text(
              "Terms of Use",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            const Text(
              "By using Cube Store, you agree to comply with our policies and terms. Users are responsible for maintaining the confidentiality of their account information. Cube Store reserves the right to terminate accounts that breach our guidelines or misuse our services.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Refund Policy Section
            const Text(
              "Refund Policy",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Cube Store allows refunds based on individual store policies. Please contact the store directly for details. In case of disputes, Cube Store will assist in facilitating communication but is not liable for refund policies managed by third-party sellers.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Shipping Policy Section
            const Text(
              "Shipping Policy",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Shipping times and rates may vary depending on the vendor and delivery location. Orders are processed within 1-3 business days. Cube Store partners with reliable couriers to ensure timely deliveries. However, delivery times may be affected by regional conditions.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // User Responsibilities Section
            const Text(
              "User Responsibilities",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Users are responsible for accurate information during registration and transactions. Misuse of the Cube Store platform, including fraudulent activities or inappropriate content, may result in account suspension or legal action.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Limitation of Liability Section
            const Text(
              "Limitation of Liability",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Cube Store is not liable for damages resulting from use of the platform. Our liability is limited to the extent allowed by law. Any issues with third-party vendors should be resolved directly with them.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 40),

            // Footer
            const Text(
              "For full details, contact us at support@cubestore.om",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
