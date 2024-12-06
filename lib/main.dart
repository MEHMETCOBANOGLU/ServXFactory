import 'package:ServXFactory/firebase_options.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:ServXFactory/utilities/%C4%B1nputWithSuggestions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ServXFactory/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ServXFactory/providers/locale_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/theme.dart';
import 'pages/homePage.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlatırken web platformunda options'ı ekleyin
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseService()),
      ],
      child: const MyApp(),
    ),
    enabled: !kReleaseMode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(builder: (context, value, child) {
      return MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: value.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      );
    });
  }
}
