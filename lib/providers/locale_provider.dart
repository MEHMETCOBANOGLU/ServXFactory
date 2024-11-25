import 'package:flutter/material.dart';
import 'package:ServXFactory/generated/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr'); // Varsayılan dil Türkçe

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!S.delegate.supportedLocales.contains(locale))
      return; // Desteklenmeyen dil kontrolü
    _locale = locale;
    notifyListeners(); // Uygulamada dinleyicilere değişikliği bildir
  }

  void clearLocale() {
    _locale = const Locale('tr'); // Varsayılan dili sıfırla
    notifyListeners();
  }
}
