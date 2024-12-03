import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/pages/Login_page.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/utilities/GridIcons_wiev.dart';
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
    _getUser();
  }

  // Kullanıcı verisini çekme işlemi
  Future<void> _getUser() async {
    try {
      userModel = await _databaseService.getUser(user.uid);
      setState(() {}); // Veriler alındığında widget'ı güncelle
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('userModel: $userModel.role');
    return Scaffold(
      body: userModel ==
              null // Veriler yüklenene kadar gösterilecek yükleme ekranı
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "401504",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "Mehmet Çobanoğlu",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "User",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                          child: const CircleAvatar(
                            radius: 68,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage:
                                  AssetImage("assets/images/vesikalık.jpg"),
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
                              underprofileIcons(FontAwesomeIcons.home,
                                  const HomePage(), false,
                                  context: context),
                              underprofileIcons(FontAwesomeIcons.solidBell,
                                  const UserPage(), false,
                                  context: context),
                              underprofileIcons(
                                  FontAwesomeIcons.signOutAlt,
                                  LoginPage(
                                    loginType: userModel!.role.isNotEmpty
                                        ? userModel!.role
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
                    personnelType: '',
                  ),
                ),
              ],
              // SizedBox(height: 20),
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
