import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/generated/l10n.dart';
import 'package:ServXFactory/pages/personnel_page.dart';
import 'package:ServXFactory/pages/user_page.dart';
import 'package:ServXFactory/providers/locale_provider.dart';

class LoginPage extends StatefulWidget {
  final String loginType;
  const LoginPage({super.key, required this.loginType});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedLanguage = 'TR';

  final List<Map<String, String>> languages = [
    {'code': 'TR', 'flag': 'assets/flags/tr.png'},
    {'code': 'EN', 'flag': 'assets/flags/en.png'},
    {'code': 'DE', 'flag': 'assets/flags/de.png'},
    {'code': 'RU', 'flag': 'assets/flags/ru.png'},
    {'code': 'FR', 'flag': 'assets/flags/fr.png'},
    {'code': 'ES', 'flag': 'assets/flags/es.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              color: AppTheme.lightTheme.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              offset: const Offset(0, 35),
              elevation: 10,
              padding: EdgeInsets.zero,
              menuPadding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 0, maxWidth: 80),
              onSelected: (String value) {
                setState(() {
                  _selectedLanguage = value;
                });
                context
                    .read<LocaleProvider>()
                    .setLocale(Locale(value.toLowerCase()));
              },
              child: Row(
                children: [
                  Image.asset(
                    languages.firstWhere(
                        (lang) => lang['code'] == _selectedLanguage)['flag']!,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 5),
                  Text(
                    _selectedLanguage,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
              itemBuilder: (BuildContext context) {
                return languages.map((lang) {
                  return PopupMenuItem<String>(
                    value: lang['code']!,
                    child: MouseRegion(
                      child: Row(
                        children: [
                          Image.asset(
                            lang['flag']!,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Text(lang['code']!),
                        ],
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      body: Column(
        children: [
          // Kaydırılabilir içerik
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 20, top: 120),
                    child: Image.asset(
                      'assets/images/logoKsp.png',
                      width: 250,
                    ),
                  ),
                  const SizedBox(height: 70),
                  _TextField('Email', Icons.email_outlined),
                  const SizedBox(height: 20),
                  _TextField('Şifre', Icons.lock_outline),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Şifreni mi unuttun?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  AccountLoginCard('Giriş Yap', widget.loginType,
                      context: context),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Divider ve RichText sabit içerik
          const Divider(
            color: Colors.white54,
            thickness: 1,
            indent: 60,
            endIndent: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
            child: RichText(
              text: TextSpan(
                text: 'Hesabın yok mu? ',
                style: TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: '  Kayıt Ol',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("  Kayıt Ol clicked");
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _TextField(text, icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          prefixIconColor: AppTheme.lightTheme.colorScheme.primary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppTheme.lightTheme.colorScheme.primary,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppTheme.lightTheme.colorScheme.onPrimary,
          hintText: text,
          hintStyle: TextStyle(color: Colors.white60),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              // color: AppTheme.lightTheme.colorScheme.secondary,
              color: AppTheme.lightTheme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

Widget AccountLoginCard(String text, String loginType,
    {required BuildContext context}) {
  return InkWell(
    onTap: () {
      print(loginType);

      loginType == 'User'
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserPage()))
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => PersonnelPage()));
    },
    child: Container(
      width: 180, // Genişlik sabit
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              AppTheme.lightTheme.colorScheme.secondary,
              AppTheme.lightTheme.colorScheme.primary,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(5, 5),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Height is determined by the contents
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true, // Allow the text to wrap to the next line
            overflow: TextOverflow.visible, // Make the overflow visible
          ),
        ],
      ),
    ),
  );
}
