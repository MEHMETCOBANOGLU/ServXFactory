import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ServXFactory/app/theme.dart';

class SignUpScreen extends StatefulWidget {
  late String loginType;

  SignUpScreen({
    super.key,
    required this.loginType,
  });

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  // Toggle buttons için kullanılan index
  int _selectedIndex = 0;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Kullanıcıyı Authentication ile kaydet
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Firestore'a ekle
        final user = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          role: widget.loginType, // Admin veya Personnel
        );

        await _databaseService.addUser(user);

        // Kullanıcıya e-posta doğrulama gönder
        await userCredential.user!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Aktivasyon için e-postanızı kontrol edin.')),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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

                  // ToggleButtons: Yönetici ve Personel Seçimi
                  if (widget.loginType == 'Personnel' ||
                      widget.loginType == 'Admin')
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ToggleButtons(
                        isSelected: [
                          widget.loginType == 'Personnel',
                          widget.loginType == 'Admin'
                        ],
                        onPressed: (int index) {
                          setState(() {
                            _selectedIndex = index;
                            widget.loginType =
                                _selectedIndex == 0 ? 'Personnel' : 'Admin';
                          });
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Personel'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Yönetici'),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                        selectedColor: Colors.white,
                        color: Colors.blue,
                        fillColor: AppTheme.lightTheme.colorScheme.secondary,
                        borderColor: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),

                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIconColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor:
                                  AppTheme.lightTheme.colorScheme.onPrimary,
                              hintText: 'E-posta',
                              hintStyle: const TextStyle(color: Colors.white60),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Geçerli bir e-posta adresi giriniz.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIconColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor:
                                  AppTheme.lightTheme.colorScheme.onPrimary,
                              hintText: 'Şifre',
                              hintStyle: const TextStyle(color: Colors.white60),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 8) {
                                return 'Şifre en az 8 karakter olmalı.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIconColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor:
                                  AppTheme.lightTheme.colorScheme.onPrimary,
                              hintText: 'Şifre (Tekrar)',
                              hintStyle: const TextStyle(color: Colors.white60),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                            validator: (value) {
                              if (value != password) {
                                return 'Şifreler uyuşmuyor.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: _register,
                          // onTap: () {
                          //   print(widget.loginType);
                          // },
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Kayıt Ol',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
