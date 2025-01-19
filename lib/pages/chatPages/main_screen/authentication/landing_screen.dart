import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/authentication/login_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/home_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/utilities/assets_manager.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_pro/constants.dart';
// import 'package:flutter_chat_pro/providers/authentication_provider.dart';
// import 'package:flutter_chat_pro/utilities/assets_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    checkAthentication();
    super.initState();
  }

  void checkAthentication() async {
    final authProvider = context.read<AuthenticationProvider>();
    bool isAuthenticated = await authProvider.checkAuthenticationState();

    navigate(isAuthenticated: isAuthenticated);
  }

  navigate({required bool isAuthenticated}) {
    if (isAuthenticated) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      print("isAuthenticated TTRUE");
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      print("isAuthenticated FALSE");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.secondaryHeaderColor,
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            children: [
              Lottie.asset(AssetsMenager.chatBubble),
              const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
