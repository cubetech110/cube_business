import 'package:cube_business/core/asset_paths.dart';
import 'package:cube_business/core/color_constant.dart';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/provider/user_provider.dart';
import 'package:cube_business/views/pages/aboutUs/aboutUS.dart';
import 'package:cube_business/views/pages/contactUs/contactUs_screen.dart';
import 'package:cube_business/views/pages/notification/notification_screen.dart';
import 'package:cube_business/views/widgets/confirm_dilog.dart';
import 'package:cube_business/views/widgets/drawer_widget/customDrawerHeader.dart';
import 'package:cube_business/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/policiesAndTearm/Policies_and_Terms.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CustomDrawerHeader(
            accountName: 'Cube Store',
            accountEmail: 'johndoe@example.com',
            backgroundImage: 'assets/icon/bg1.png',
            avatarImage: 'assets/images/admin.jpeg',
          ),
          ListTile(
            leading: IconWidget(
              isbgColor: false,
              bgColor: AppColor.primaryColor,
              iconPath: AssetPaths.houseSvg,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Home
            },
          ),
          ListTile(
            leading: Stack(
              children: [
                IconWidget(
                  isbgColor: false,
                  bgColor: AppColor.primaryColor,
                  iconPath: AssetPaths.notificationsSvg,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            title: const Text('Notifications'),
            onTap: () {navigateTo(context, NotificationScreen());},
          ),
          ListTile(
            leading: IconWidget(
              isbgColor: false,
              bgColor: AppColor.primaryColor,
              iconPath: AssetPaths.infoSvg,
            ),
            title: const Text('About Us'),
            onTap: () {
              navigateTo(context, const AboutUs());
            },
          ),
          ListTile(
            leading: IconWidget(
              isbgColor: false,
              bgColor: AppColor.primaryColor,
              iconPath: AssetPaths.contactSvg,
            ),
            title: const Text('Support Team'),
            onTap: () {
              navigateTo(context, ContactUsPage());
            },
          ),
          ListTile(
            leading: IconWidget(
              isbgColor: false,
              bgColor: AppColor.primaryColor,
              iconPath: AssetPaths.infoSvg,
            ),
            title: const Text('Policies and Terms'),
            onTap: () {
              navigateTo(context,const PoliciesAndTermsPage());
            },
          ),
          ListTile(
            leading: IconWidget(
              isbgColor: false,
              bgColor: AppColor.primaryColor,
              iconPath: AssetPaths.logoutSvg,
            ),
            title: const Text('Log Out'),
            onTap: () {
              showConfirmDialog(
                context: context,
                title: 'Log Out',
                content: 'Are you sure you want to log out?',
                onConfirm: () {
                  UserProvider().signOut(context);
                },
              );
              // Handle logout
            },
          ),
          ListTile(
            leading: IconWidget(
              isbgColor: false,
              bgColor: AppColor.primaryColor,
              iconPath: AssetPaths.disableAcountSvg,
            ),
            title: const Text('Disable Account'),
            onTap: () {
           showConfirmDialog(
                context: context,
                title: 'Disable Account',
                content: 'Are you sure you want to Disable Account?',
                onConfirm: () {
                  UserProvider().signOut(context);
                },
              );            },
          ),
        ],
      ),
    );
  }
}
