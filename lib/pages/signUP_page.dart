import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/pages/Login_page.dart';
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
  String userName = '';
  bool _isPasswordVisible = true; // Password Visiblty
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
          name: userName,
          email: email,
          role: widget.loginType, telNo: '', adress: '', // Admin veya Personnel
        );

        await _databaseService.addUser(user);

        // Kullanıcıya e-posta doğrulama gönder
        await userCredential.user!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Aktivasyon için e-postanızı kontrol edin.')),
        );

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                      loginType: widget.loginType,
                    )));
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
                        borderRadius: BorderRadius.circular(30),
                        selectedColor: Colors.white,
                        color: Colors.blue,
                        fillColor: AppTheme.lightTheme.colorScheme.secondary,
                        borderColor: AppTheme.lightTheme.colorScheme.primary,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Personel'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Yönetici'),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _TextFormField('Kullanıcı Adı'),
                        _TextFormField('E-posta'),
                        _TextFormField('Şifre'),
                        _TextFormField('Şifre (tekrar)'),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: _register,
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

  Padding _TextFormField(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 40,
      ),
      child: TextFormField(
        obscureText: text == 'Şifre' || text == 'Şifre (tekrar)'
            ? _isPasswordVisible
            : _isPasswordVisible,
        decoration: InputDecoration(
          prefixIconColor: AppTheme.lightTheme.colorScheme.primary,
          suffixIcon: text == 'Şifre' || text == 'Şifre (tekrar)'
              ? IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
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
        onChanged: (value) {
          userName = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen kullanıcı adınızı giriniz.';
          }
          if (!value.contains(RegExp(r'^[a-zA-Z0-9çÇöÖşŞıİğĞüÜ\s]{3,}$'))) {
            return 'Kullanıcı adınızı oluşturmak için en az 3 harf gereklidir.';
          }
          if (value.isEmpty || !value.contains('@')) {
            return 'Geçerli bir e-posta adresi giriniz.';
          }
          if (value.isEmpty || value.length < 8) {
            return 'Şifre en az 8 karakter olmalı.';
          }
          if (value != password) {
            return 'Şifreler uyuşmuyor.';
          } else {
            return null; // Valid input
          }
        },
      ),
    );
  }
}
