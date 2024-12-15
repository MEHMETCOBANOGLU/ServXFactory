import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/controller/textediting.dart';
import 'package:ServXFactory/services/ai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBoxBottom extends StatefulWidget {
  const TextBoxBottom({
    super.key,
  });

  @override
  State<TextBoxBottom> createState() => _TextBoxBottomState();
}

class _TextBoxBottomState extends State<TextBoxBottom> {
  ValueNotifier<bool> isFocus = ValueNotifier<bool>(false);
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      isFocus.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: messageController,
              style: GoogleFonts.dmSans(
                  color: Colors.white.withOpacity(0.8), fontSize: 13),
              decoration: InputDecoration(
                hintText: "Bir mesaj yazın...",
                hintStyle: GoogleFonts.dmSans(
                    color: Colors.white.withOpacity(0.8), fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1020),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1020),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1020),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              onSubmitted: (value) async {
                await Ai.sendMessage();
              },
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          GestureDetector(
            onTap: () async {
              print('object');
              await Ai.sendMessage();
            },
            child: ValueListenableBuilder(
              valueListenable: isFocus,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: isFocus.value
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.surface,
                        width: 2,
                      ),
                      shape: BoxShape.circle),
                  width: 51,
                  height: 51,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.send_rounded,
                      color: isFocus.value
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.surface,
                      size: 22,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
