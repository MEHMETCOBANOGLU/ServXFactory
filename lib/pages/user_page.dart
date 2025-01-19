import 'dart:io';

import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/pages/Login_page.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/utilities/GridIcons_wiev.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final PageController _pageController = PageController();
  final DatabaseService _databaseService = DatabaseService();
  final user = FirebaseAuth.instance.currentUser!;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    context.read<DatabaseService>().fetchUser(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseService>(
        builder: (context, databaseService, child) {
          final userModel = databaseService.currentUser;

          if (userModel == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Container(
                color: AppTheme.lightTheme.colorScheme.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            children: [
                              Tooltip(
                                message: 'Kullanıcı ID',
                                child: Text(
                                  userModel.id.isNotEmpty
                                      ? userModel.id
                                      : 'ID bulunamadı',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Text(
                                userModel.name.isNotEmpty
                                    ? userModel.name
                                    : 'Ad bulunamadı',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userModel.role.isNotEmpty
                                    ? userModel.role
                                    : 'Rol bulunamadı',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor:
                            AppTheme.lightTheme.colorScheme.primary,
                        child: CircleAvatar(
                          radius: 68,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: userModel.imageUrl!.isNotEmpty
                                ? FileImage(File(userModel.imageUrl!))
                                : const AssetImage(
                                    'assets/images/user_icon.png'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 20, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            underprofileIcons(
                                FontAwesomeIcons.home, const HomePage(), false,
                                context: context),
                            underprofileIcons(FontAwesomeIcons.solidBell,
                                const UserPage(), false,
                                context: context),
                            underprofileIcons(
                                FontAwesomeIcons.signOutAlt,
                                LoginPage(
                                  loginType: userModel.role.isNotEmpty
                                      ? userModel.role
                                      : 'rol bulunamadı',
                                ),
                                true,
                                context: context),
                          ]),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GridIcons(
                  context,
                  pageController: _pageController,
                  homePage: false,
                  personnelType: userModel.role.isNotEmpty
                      ? userModel.role
                      : 'rol bulunamadı',
                ),
              ),
            ],
            // SizedBox(height: 20),
          );
        },
      ),
    );
  }
}

Widget underprofileIcons(icon, Widget route, bool logout,
    {required BuildContext context}) {
  return InkWell(
    onTap: () async {
      print('deneme: $logout');
      if (logout == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('email'); // Email'i temizle
        await prefs.setBool('isLoggedIn', false); // Giriş durumunu false yap
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      } else {
        print('object');
        print('deneme: $logout');
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      }
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      height: 40,
      width: 40,
      child: Center(
        child: FaIcon(
          icon,
          color: AppTheme.lightTheme.colorScheme.primary,
        ),
      ),
    ),
  );
}
