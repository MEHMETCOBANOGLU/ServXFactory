import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/controller/scrollcontroller.dart';
import 'package:ServXFactory/controller/value.dart';
import 'package:ServXFactory/services/ai.dart';
import 'package:ServXFactory/utilities/messageBox.dart';
import 'package:ServXFactory/utilities/textbox.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface, // Renk
        elevation: 0, // Gölgeyi kaldırır
        centerTitle: true,
        title: Text(
          "Dijital Asistan",
          style: GoogleFonts.dmSans(
            color: AppTheme.lightTheme.colorScheme.secondary,
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
                // SizedBox(
                //   height: 36,
                // ),
                ValueListenableBuilder(
                    valueListenable: messageList,
                    builder: (context, value, child) {
                      return Expanded(
                          child: SingleChildScrollView(
                              controller: scrollController,
                              // physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: value,
                              )));
                    }),
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
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      blurRadius: 20,
                      offset: Offset(10, 6),
                      spreadRadius: 20,
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
