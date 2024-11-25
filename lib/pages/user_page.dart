import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/utilities/GridIcons_wiev.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppTheme.lightTheme.colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: const Center(
                      child: Column(
                        children: [
                          Text(
                            "401504",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
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
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        underprofileIcons(
                            FontAwesomeIcons.home, const HomePage(),
                            context: context),
                        underprofileIcons(
                            FontAwesomeIcons.solidBell, const UserPage(),
                            context: context),
                        underprofileIcons(
                            FontAwesomeIcons.signOutAlt, const UserPage(),
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

Widget underprofileIcons(icon, Widget route, {required BuildContext context}) {
  return InkWell(
    onTap: () {
      print('object');
      Navigator.push(context, MaterialPageRoute(builder: (context) => route));
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
