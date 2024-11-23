import 'package:cube_business/core/asset_paths.dart';
import 'package:cube_business/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Contact us'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: IconWidget(isbgColor: true,
                bgColor: Colors.blue, iconPath: AssetPaths.facebookPng),
            title: const Text('Facebook'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Facebook page
            },
          ),
          ListTile(
            title: const Text('X'),
            leading:
                IconWidget(bgColor: Colors.black, iconPath: AssetPaths.xPng, isbgColor: true,),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Twitter page
            },
          ),
          ListTile(
            leading: IconWidget(
                bgColor: Colors.red, iconPath: AssetPaths.instagramPng, isbgColor: true,),
            title: const Text('Instagram'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Instagram page
            },
          ),
                    ListTile(
            leading: IconWidget(
                bgColor: Colors.green, iconPath: 'assets/icon/whatsapp.svg', isbgColor: true,),
            title: const Text('WhatsApp'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Instagram page
            },
          ),
          const Spacer(),

        ],
      ),
    );
  }
}
