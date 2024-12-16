import 'package:flutter/material.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/controller/scrollcontroller.dart';
import 'package:ServXFactory/controller/textediting.dart';
import 'package:ServXFactory/controller/value.dart';
import 'package:ServXFactory/services/ai.dart';
import 'package:ServXFactory/utilities/messageBox.dart';
import 'package:ServXFactory/utilities/textbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cosmos/cosmos.dart';

class DigitalAssistan extends StatefulWidget {
  const DigitalAssistan({super.key});

  @override
  State<DigitalAssistan> createState() => _DigitalAssistanState();
}

class _DigitalAssistanState extends State<DigitalAssistan> {
  @override
  void initState() {
    super.initState();
    Ai.initializeChat(); // Sohbet başladığında ilk mesajı yükler
  }

  bool _isRowVisible = true; // Row'un görünürlük kontrolü

  // Liste içeriği
  final List<Map<String, String>> options = [
    {
      'title': 'Uygulama Özellikleri Hakkında Bilgi Almak',
      'response': 'Uygulama Özellikleri Hakkında Bilgi Almak...'
    },
    {
      'title': 'Teknik Destek ve Sorun Giderme',
      'response': 'Teknik destek için size nasıl yardımcı olabilirim?'
    },
    {
      'title': 'Yedek Parça Yönetimi',
      'response': 'Yedek parçalarla ilgili bilgi almak istiyorum.'
    },
    {
      'title': 'Veri Analitiği ve Optimizasyon',
      'response': 'Veri analitiği raporlarına buradan ulaşabilir miyim?'
    },
    {
      'title': 'Teknik Destek Ekibine Bağlanmak',
      'response': 'Teknik destek ekibine bağlanmak istiyorum.'
    },
  ];

  // Seçenek tıklandığında mevcut sendMessage fonksiyonunu kullan
  void _handleOption(String response) {
    messageController.text = response;
    Ai.sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Dijital Asistan",
          style: GoogleFonts.dmSans(
            color: AppTheme.lightTheme.colorScheme.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: messageList,
                    builder: (context, value, child) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Column(children: value),
                      );
                    },
                  ),
                ),
                // Row'u aç/kapat butonu
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRowVisible = !_isRowVisible;
                        });
                      },
                      child: Icon(
                        _isRowVisible
                            ? Icons.keyboard_double_arrow_down_rounded
                            : Icons.double_arrow_rounded,
                      )),
                ),
                // Animasyonlu Row
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  height: _isRowVisible ? 50 : 0, // Yüksekliği kontrol eder
                  color: Colors.white,
                  child: _isRowVisible
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: options.map((option) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _handleOption(option['response']!),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppTheme.lightTheme.colorScheme.surface,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    option['title']!,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const TextBoxBottom(),
                Text(
                  "Dijital Asistan hata yapabilir.",
                  style: GoogleFonts.dmSans(
                    color: AppTheme.lightTheme.colorScheme.surface
                        .withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // )
              ],
            ),
            Container(
              // width: width(context) * 0.97,
              decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lightTheme.colorScheme.onSecondary,
                      blurRadius: 20,
                      offset: Offset(10, 6),
                      spreadRadius: 8,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Dijital Asistan",
                  //   style: GoogleFonts.dmSans(
                  //       color: AppTheme.lightTheme.colorScheme.secondary,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
