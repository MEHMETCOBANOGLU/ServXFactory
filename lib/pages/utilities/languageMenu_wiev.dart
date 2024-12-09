import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/providers/locale_provider.dart';

class LanguageMenu extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageSelected;

  // Dil ve bayrak bilgileri
  final List<Map<String, String>> languages = [
    {'code': 'TR', 'flag': 'assets/flags/tr.png'},
    {'code': 'EN', 'flag': 'assets/flags/en.png'},
    {'code': 'DE', 'flag': 'assets/flags/de.png'},
    {'code': 'RU', 'flag': 'assets/flags/ru.png'},
    {'code': 'FR', 'flag': 'assets/flags/fr.png'},
    {'code': 'ES', 'flag': 'assets/flags/es.png'},
  ];

  LanguageMenu({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
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
        onLanguageSelected(value);
        context.read<LocaleProvider>().setLocale(Locale(value.toLowerCase()));
      },
      child: Row(
        children: [
          Image.asset(
            languages.firstWhere(
                (lang) => lang['code'] == selectedLanguage)['flag']!,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 5),
          Text(
            selectedLanguage,
            style: const TextStyle(color: Colors.white),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
      itemBuilder: (BuildContext context) {
        return languages.map((lang) {
          return PopupMenuItem<String>(
            value: lang['code']!,
            child: Row(
              children: [
                Image.asset(
                  lang['flag']!,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                Text(lang['code']!),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
