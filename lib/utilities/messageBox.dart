import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/utilities/typingAnimation.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBox extends StatelessWidget {
  final bool isDigitalAssistan;
  final String message;
  final String timestamp;
  final bool isLoading; // Yükleniyor durumu

  const MessageBox({
    super.key,
    required this.isDigitalAssistan,
    required this.message,
    required this.timestamp,
    this.isLoading = false, // Varsayılan olarak false
  });

  @override
  Widget build(BuildContext context) {
    return isDigitalAssistan ? digitalAssistan(context) : me(context);
  }

  Row digitalAssistan(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8.0),
          width: width(context) * 0.6,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Raya',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                  fontSize: 14),
            ),
            isLoading
                ? const TypingAnimation() // Animasyonlu üç nokta
                : Text(
                    message,
                    style:
                        GoogleFonts.dmSans(color: Colors.white, fontSize: 12),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  timestamp,
                  style: GoogleFonts.dmSans(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ]),
        )
      ],
    );
  }

  Row me(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8.0),
          width: width(context) * 0.6,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Siz',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontSize: 14),
              ),
              Text(
                message,
                style: GoogleFonts.dmSans(color: Colors.white, fontSize: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timestamp,
                    style:
                        GoogleFonts.dmSans(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
