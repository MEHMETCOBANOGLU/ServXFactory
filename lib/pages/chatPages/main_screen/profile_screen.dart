// import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/utilities/global_methods.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/app_bar_back_button.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/group_details_card.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/settings_list_tile.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  UserModel? userModel;
  final user = FirebaseAuth.instance.currentUser!;
  final DatabaseService _databaseService = DatabaseService();

  // Kullanıcı verisini çekme işlemi
  Future<void> _getUser() async {
    try {
      userModel = await _databaseService.getUser(widget.userId);
      setState(() {}); // Veriler alındığında widget'ı güncelle
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  // get the saved theme mode
  // void getThemeMode() async {
  //   // get the saved theme mode
  //   // final savedThemeMode = await AdaptiveTheme.getThemeMode();
  //   // check if the saved theme mode is dark
  //   if (savedThemeMode == AdaptiveThemeMode.dark) {
  //     // set the isDarkMode to true
  //     setState(() {
  //       isDarkMode = true;
  //     });
  //   } else {
  //     // set the isDarkMode to false
  //     setState(() {
  //       isDarkMode = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    // getThemeMode();
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    // get user data from arguments
    // final uid = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: StreamBuilder(
        stream: context
            .read<AuthenticationProvider>()
            .userStream(userID: widget.userId),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // null kontrolü
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(
                child: Text('User data not found + ${widget.userId}'));
          }

          // null değilse veri çekme
          final userModel =
              UserModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoDetailsCard(
                    userModel: userModel,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Settings',
                      style: GoogleFonts.openSans(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Column(
                      children: [
                        SettingsListTile(
                          title: 'Account',
                          icon: Icons.person,
                          iconContainerColor: Colors.deepPurple,
                          onTap: () {
                            // navigate to account settings
                          },
                        ),
                        SettingsListTile(
                          title: 'My Media',
                          icon: Icons.image,
                          iconContainerColor: Colors.green,
                          onTap: () {
                            // navigate to account settings
                          },
                        ),
                        SettingsListTile(
                          title: 'Notifications',
                          icon: Icons.notifications,
                          iconContainerColor: Colors.red,
                          onTap: () {
                            // navigate to account settings
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Column(
                      children: [
                        SettingsListTile(
                          title: 'Help',
                          icon: Icons.help,
                          iconContainerColor: Colors.yellow,
                          onTap: () {
                            // navigate to account settings
                          },
                        ),
                        SettingsListTile(
                          title: 'Share',
                          icon: Icons.share,
                          iconContainerColor: Colors.blue,
                          onTap: () {
                            // navigate to account settings
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            isDarkMode
                                ? Icons.nightlight_round
                                : Icons.wb_sunny_rounded,
                            color: isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      title: const Text('Change theme'),
                      trailing: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            // set the isDarkMode to the value
                            setState(() {
                              isDarkMode = value;
                            });
                            // check if the value is true
                            if (value) {
                              // set the theme mode to dark
                              // AdaptiveTheme.of(context).setDark();
                            } else {
                              // set the theme mode to light
                              // AdaptiveTheme.of(context).setLight();
                            }
                          }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Column(
                      children: [
                        SettingsListTile(
                          title: 'Logout',
                          icon: Icons.logout_outlined,
                          iconContainerColor: Colors.red,
                          onTap: () {
                            showMyAnimatedDialog(
                              context: context,
                              title: 'Logout',
                              content: 'Are you sure you want to logout?',
                              textAction: 'Logout',
                              onActionTap: (value) {
                                if (value) {
                                  // logout
                                  context
                                      .read<AuthenticationProvider>()
                                      .logout()
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/loginScreen',
                                      (route) => false,
                                    );
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
