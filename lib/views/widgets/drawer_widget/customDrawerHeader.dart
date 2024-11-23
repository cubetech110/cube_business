import 'package:cube_business/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final String backgroundImage;
  final String avatarImage;

  const CustomDrawerHeader({super.key, 
    required this.accountName,
    required this.accountEmail,
    required this.backgroundImage,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    double radius = 70;
    return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius),
                ),
        
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                        backgroundImage: NetworkImage(userProvider.currentStore!.logoUrl!),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.currentStore!.name,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userProvider.currentUser!.email!,
                          style: const TextStyle(
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
    );
  }
}
