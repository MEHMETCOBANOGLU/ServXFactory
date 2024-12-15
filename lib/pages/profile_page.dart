import 'dart:ffi';
import 'dart:io';

import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/pages/Login_page.dart';
import 'package:ServXFactory/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/utilities/GridIcons_wiev.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PageController _pageController = PageController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();
  final user = FirebaseAuth.instance.currentUser!;
  final ImagePicker _picker = ImagePicker();
  late String _imagePath = '';
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  // Kullanıcı verisini çekme işlemi
  Future<void> _getUser() async {
    try {
      userModel = await _databaseService.getUser(user.uid);
      setState(() {}); // Veriler alındığında widget'ı güncelle
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  void _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (userModel != null) {
          final updatedUser = UserModel(
            id: userModel!.id,
            name: _userNamecontroller.text.isEmpty
                ? userModel!.name
                : _userNamecontroller.text,
            email: _emailcontroller.text.isEmpty
                ? userModel!.email
                : _emailcontroller.text,
            role: userModel!.role,
            telNo: _phonecontroller.text.isEmpty
                ? userModel!.telNo
                : _phonecontroller.text,
            adress: _addresscontroller.text.isEmpty
                ? userModel!.adress
                : _addresscontroller.text,
            imageUrl: _imagePath.isNotEmpty ? _imagePath : userModel!.imageUrl,
          );

          await context.read<DatabaseService>().updateUser(updatedUser);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bilgileriniz güncellendi.')),
          );

          Navigator.pop(context); // Güncelleme sonrası geri dön
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kullanıcı modeli yüklenemedi.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${e.toString()}')),
        );
      }
    }
  }

  void _pop() async {
    print('geriye donuyor');
    Navigator.pop(context);
  }

  //Resim seçme fonksiyonu #resimm,imgg
  Future<void> _pickImage() async {
    print("Resim seçiliyor...");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);

      String imagePath = await _saveImagePermanently(file);
      print("Image path: $imagePath");

      setState(() {
        _imagePath = imagePath;
      });

      print("Image path_2: $_imagePath");
    }
  }

  // Resimleri kalıcı olarak kaydetme fonksiyonu1
  Future<String> _saveImagePermanently(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final newPath = path.join(directory.path, fileName);

    final savedImage = await image.copy(newPath);
    return savedImage.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true, // Klavye açıldığında içerik yukarı kayar

      body: userModel == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Üst bölüm: Profil bilgileri ve fotoğraf
                Container(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              children: [
                                Tooltip(
                                  message: 'Kullanıcı ID',
                                  child: Text(
                                    userModel!.id.isNotEmpty
                                        ? userModel!.id
                                        : 'ID bulunamadı',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Text(
                                  userModel!.name.isNotEmpty
                                      ? userModel!.name
                                      : 'Ad bulunamadı',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  userModel!.role.isNotEmpty
                                      ? userModel!.role
                                      : 'Rol bulunamadı',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.primary,
                          child: CircleAvatar(
                            radius: 68,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: _imagePath.isNotEmpty
                                  ? FileImage(File(_imagePath))
                                  : FileImage(
                                      File(userModel!.imageUrl!),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              underprofileIcons(FontAwesomeIcons.home,
                                  const HomePage(), false,
                                  context: context),
                              underprofileIcons(FontAwesomeIcons.solidBell,
                                  const ProfilePage(), false,
                                  context: context),
                              underprofileIcons(
                                  FontAwesomeIcons.signOutAlt,
                                  LoginPage(
                                    loginType: userModel!.role.isNotEmpty
                                        ? userModel!.role
                                        : 'rol bulunamadı',
                                  ),
                                  true,
                                  context: context),
                            ]),
                      )
                    ],
                  ),
                ),
                // Alt bölüm: Kaydırılabilir Form alanı
                Expanded(
                  child: SingleChildScrollView(
                    // physics: const BouncingScrollPhysics(),
                    child: Container(
                      color: Colors.white,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _TextField(
                                userModel!.name.isNotEmpty
                                    ? userModel!.name
                                    : 'Kullanıcı adı',
                                FontAwesomeIcons.user,
                                _userNamecontroller),
                            _TextField(
                                userModel!.email.isNotEmpty
                                    ? userModel!.email
                                    : 'E-posta',
                                FontAwesomeIcons.envelope,
                                _emailcontroller),
                            _TextField(
                                userModel!.telNo.isNotEmpty
                                    ? userModel!.telNo
                                    : 'Telefon',
                                FontAwesomeIcons.phone,
                                _phonecontroller),
                            _TextField(
                                userModel!.adress.isNotEmpty
                                    ? userModel!.adress
                                    : 'Adres',
                                FontAwesomeIcons.addressCard,
                                _addresscontroller),
                            // Fotoğraf ekleme butonu
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 310,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppTheme
                                                .lightTheme.colorScheme.primary,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: _pickImage,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.camera,
                                              size: 30,
                                              color: AppTheme.lightTheme
                                                  .colorScheme.primary,
                                            ),
                                            Text(
                                              'Fotograf Ekle',
                                              style: TextStyle(
                                                  color: AppTheme.lightTheme
                                                      .colorScheme.primary,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            // Güncelle ve İptal butonları
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, left: 20, right: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    editprofileIcons(
                                      FontAwesomeIcons.cancel,
                                      'İptal',
                                      context: context,
                                      onTap: _pop,
                                    ),
                                    editprofileIcons(
                                      FontAwesomeIcons.solidSave,
                                      'Güncelle',
                                      context: context,
                                      onTap: _updateUserInfo,
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _TextField(text, icon, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Column(
        children: [
          TextFormField(
            enabled: controller == _emailcontroller ? false : true,
            controller: controller,
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
        ],
      ),
    );
  }
}

Widget underprofileIcons(icon, Widget route, bool logout,
    {required BuildContext context}) {
  return InkWell(
    onTap: () async {
      print('deneme: $logout');
      if (logout == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('email'); // Email'i temizle
        await prefs.setBool('isLoggedIn', false); // Giriş durumunu false yap
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      } else {
        print('object');
        print('deneme: $logout');
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      }
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      height: 40,
      width: 40,
      child: Center(
        child: FaIcon(
          icon,
          color: AppTheme.lightTheme.colorScheme.primary,
        ),
      ),
    ),
  );
}

Widget editprofileIcons(icon, String text,
    {required BuildContext context, required VoidCallback onTap}) {
  return InkWell(
    onTap: () async {
      if (text == 'Güncelle') {
        onTap();
      } else if (text == 'İptal') {
        onTap();
      }
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppTheme.lightTheme.colorScheme.primary),
      height: 50,
      width: 160,
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: FaIcon(
              icon,
              color: Colors.white,
            ),
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
