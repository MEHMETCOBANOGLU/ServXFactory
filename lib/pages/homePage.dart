import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/generated/l10n.dart';
import 'package:ServXFactory/pages/Login_page.dart';
import 'package:ServXFactory/pages/utilities/GridIcons_wiev.dart';
import 'package:ServXFactory/providers/locale_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
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
                  _selectedLanguage = value; // Seçili dili güncelle
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
                      // when hover on menu item row will change color to white
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Image.asset(
              'assets/images/logoKsp.png',
              width: 250,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridIcons(
              context,
              pageController: _pageController,
              homePage: true,
              personnelType: '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AccountLoginCard(
                    S.of(context).UserLogin, FontAwesomeIcons.userTie, "User",
                    context: context),
                AccountLoginCard(S.of(context).PersonnelLogin,
                    FontAwesomeIcons.userGear, "Personnel",
                    context: context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Kullanıcı Girişi Butonunu Metod Olarak Tanımlama
Widget AccountLoginCard(String text, IconData icon, String loginType,
    {required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(loginType: loginType),
        ),
      );
    },
    child: Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: text == S.of(context).UserLogin
              ? Alignment.centerRight
              : Alignment.centerLeft,
          end: text == S.of(context).UserLogin
              ? Alignment.centerLeft
              : Alignment.centerRight,
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
        borderRadius: text == S.of(context).UserLogin
            ? BorderRadius.horizontal(right: Radius.circular(18))
            : BorderRadius.horizontal(left: Radius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (text != S.of(context).UserLogin)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FaIcon(
                    icon,
                    color: AppTheme.lightTheme.colorScheme.surface,
                  ),
                ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              if (text == S.of(context).UserLogin)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FaIcon(
                    icon,
                    color: AppTheme.lightTheme.colorScheme.surface,
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
