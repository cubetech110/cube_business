import 'package:cube_business/core/asset_paths.dart';
import 'package:cube_business/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Contact us'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: IconWidget(isbgColor: true,
                bgColor: Colors.blue, iconPath: AssetPaths.facebookPng),
            title: Text('Facebook'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Facebook page
            },
          ),
          ListTile(
            title: Text('X'),
            leading:
                IconWidget(bgColor: Colors.black, iconPath: AssetPaths.xPng, isbgColor: true,),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Twitter page
            },
          ),
          ListTile(
            leading: IconWidget(
                bgColor: Colors.red, iconPath: AssetPaths.instagramPng, isbgColor: true,),
            title: Text('Instagram'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Instagram page
            },
          ),
                    ListTile(
            leading: IconWidget(
                bgColor: Colors.green, iconPath: 'assets/icon/whatsapp.svg', isbgColor: true,),
            title: Text('WhatsApp'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Instagram page
            },
          ),
          Spacer(),

        ],
      ),
    );
  }
}
