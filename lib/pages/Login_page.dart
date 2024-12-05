import 'package:ServXFactory/pages/forgotPass_page.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/signUP_page.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:ServXFactory/utilities/%C4%B1nputWithSuggestions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/generated/l10n.dart';
import 'package:ServXFactory/pages/personnel_page.dart';
import 'package:ServXFactory/pages/user_page.dart';
import 'package:ServXFactory/providers/locale_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final String loginType;
  const LoginPage({super.key, required this.loginType});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedLanguage = 'TR';

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  List<String> _filteredEmails = [];
  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _isFocus = _emailFocusNode.hasFocus;
      });
    });
  }

  // E-posta girildiğinde, listeyi filtrele
  void _filterEmails(String query) async {
    List<String> previousEmails = await EmailSuggestion.loadEmails();
    setState(() {
      _filteredEmails = EmailSuggestion.filterEmails(query, previousEmails);
    });
  }

  // TextField odakta olduğunda tüm önceki e-postaları göster
  void _showAllEmails() async {
    List<String> previousEmails = await EmailSuggestion.loadEmails();
    setState(() {
      _filteredEmails = previousEmails;
    });
  }

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
    return WillPopScope(
      onWillPop: () async {
        // Kullanıcı geri tuşuna veya kaydırma hareketine bastığında çalışacak
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        return false; // Varsayılan geri navigasyonu engelle
      },
      child: Scaffold(
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
                    const SizedBox(width: 5),
                    Text(
                      _selectedLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
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
                            const SizedBox(width: 10),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 20, top: 120),
                        child: Image.asset(
                          'assets/images/logoKsp.png',
                          width: 250,
                        ),
                      ),
                      const SizedBox(height: 70),
                      _TextField('Email', Icons.email_outlined,
                          _emailcontroller, _emailFocusNode),
                      const SizedBox(height: 20),
                      _TextField('Şifre', Icons.lock_outline,
                          _passwordController, _passwordFocusNode),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage(),
                                      ));
                                },
                                child: const Text(
                                  'Şifreni mi unuttun?',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      AccountLoginCard(
                          'Giriş Yap',
                          widget.loginType,
                          _emailcontroller,
                          _passwordController,
                          _auth,
                          _formKey,
                          _databaseService,
                          context: context),
                      const SizedBox(height: 20),
                    ],
                  ),
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
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  children: [
                    TextSpan(
                      text: '  Kayıt Ol',
                      style: TextStyle(
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignUpScreen(loginType: widget.loginType),
                            ),
                          );

                          print("  Kayıt Ol clicked");
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _TextField(text, icon, controller, focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (value) {
              _filterEmails(value); // E-posta girildikçe önerileri filtrele
            },
            onTap:
                _showAllEmails, // Odaklandığında tüm e-posta adreslerini göster
            onEditingComplete: () {
              String email =
                  controller.text; // Controller'dan e-posta değerini al
              print("onEditingComplete tetiklendi. E-posta: $email");
              EmailSuggestion.saveEmail(email); // E-posta girildiğinde kaydet
            },
            validator: controller == _emailcontroller
                ? (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Geçerli bir e-posta adresi giriniz.';
                    }
                    return null;
                  }
                : (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Şifre en az 8 karakter olmalı.';
                    }
                    return null;
                  },
            obscureText: controller == _passwordController ? true : false,
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
              hintStyle: const TextStyle(color: Colors.white60),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
          ),
          if (_isFocus &&
              _filteredEmails.isNotEmpty &&
              controller == _emailcontroller)
            Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredEmails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredEmails[index]),
                    onTap: () {
                      controller.text = _filteredEmails[index];
                      setState(() {
                        _filteredEmails =
                            []; // Seçildikten sonra listeyi temizle
                      });
                      focusNode.unfocus(); // Focus'u kaybettir
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

Widget AccountLoginCard(
    String text,
    String loginType,
    TextEditingController emailcontroller,
    TextEditingController passwordcontroller,
    FirebaseAuth auth,
    GlobalKey<FormState> formKey,
    DatabaseService databaseService,
    {required BuildContext context}) {
  return InkWell(
    onTap: () async {
      if (formKey.currentState?.validate() ?? false) {
        try {
          final userCredential = await auth.signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text,
          );

          // if (userCredential.user!.emailVerified) { // şimdlik email doğrulamayı devre dışı bırakıyorum açarsın sonra
          if (true) {
            final user = userCredential.user;
            if (user != null) {
              // SharedPreferences ile kullanıcı giriş bilgilerini kaydetme
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'email', userCredential.user!.email!); // Email kaydediliyor
              await prefs.setBool('isLoggedIn',
                  true); // Kullanıcının giriş yapıp yapmadığını kontrol et

              // Kullanıcı giriş yaptıysa, Firestore'dan bilgilerini al
              final userModel = await databaseService.getUser(user.uid);
              if (userModel != null) {
                // Kullanıcı bilgilerini aldıktan sonra istediğiniz işlemi yapabilirsiniz
                print('Kullanıcı Adı: ${userModel.name}');
                print('Kullanıcı Rolü: ${userModel.role}');

                print(loginType);
                if (loginType == 'User' && userModel.role == 'User') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserPage()));
                } else if ((loginType == 'Personnel' || loginType == 'Admin') &&
                    (userModel.role == 'Personnel' ||
                        userModel.role == 'Admin')) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PersonnelPage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Lütfen kullanıcı giriş sayfasından giriş yapınız. Personel ve Yönetici yetkilileri bu sayfadan giriş yapabilir.')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Lütfen e-posta adresinizi doğrulayın.')),
                );
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lütfen e-posta adresinizi doğrulayın.')),
            );
          }
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata: ${e.message}')),
          );
        }
      }
    },
    child: Container(
      width: 180, // Sabit genişlik
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
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // İçerik yüksekliği içeriğe göre belirlenir
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true, // Text'in bir sonraki satıra geçmesine izin verir
            overflow: TextOverflow.visible, // Overflowu gösterir
          ),
        ],
      ),
    ),
  );
}
