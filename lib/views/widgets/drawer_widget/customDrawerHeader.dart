import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final String backgroundImage;
  final String avatarImage;

  CustomDrawerHeader({
    required this.accountName,
    required this.accountEmail,
    required this.backgroundImage,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    double radius = 70;
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(radius),
            ),

      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(avatarImage),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountName,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      accountEmail,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
