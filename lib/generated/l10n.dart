// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message(
      'About Us',
      name: 'AboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Introduction Video`
  String get IntroductionVideo {
    return Intl.message(
      'Introduction Video',
      name: 'IntroductionVideo',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get Products {
    return Intl.message(
      'Products',
      name: 'Products',
      desc: '',
      args: [],
    );
  }

  /// `Error Support System`
  String get ErrorSupportSystem {
    return Intl.message(
      'Error Support System',
      name: 'ErrorSupportSystem',
      desc: '',
      args: [],
    );
  }

  /// `Latest Updates`
  String get LatestUpdates {
    return Intl.message(
      'Latest Updates',
      name: 'LatestUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Media Center`
  String get MediaCenter {
    return Intl.message(
      'Media Center',
      name: 'MediaCenter',
      desc: '',
      args: [],
    );
  }

  /// `Blogs`
  String get Blogs {
    return Intl.message(
      'Blogs',
      name: 'Blogs',
      desc: '',
      args: [],
    );
  }

  /// `References`
  String get References {
    return Intl.message(
      'References',
      name: 'References',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get Contact {
    return Intl.message(
      'Contact',
      name: 'Contact',
      desc: '',
      args: [],
    );
  }

  /// `Ksp Map`
  String get KspMap {
    return Intl.message(
      'Ksp Map',
      name: 'KspMap',
      desc: '',
      args: [],
    );
  }

  /// `User Login`
  String get UserLogin {
    return Intl.message(
      'User Login',
      name: 'UserLogin',
      desc: '',
      args: [],
    );
  }

  /// `Personnel Login`
  String get PersonnelLogin {
    return Intl.message(
      'Personnel Login',
      name: 'PersonnelLogin',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
