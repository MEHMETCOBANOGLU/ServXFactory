import 'package:ServXFactory/pages/chatPages/main_screen/widgets/botton_chat_field.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/chat_app_bar.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/chat_list.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/group_chat_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactUID;
  final String contactName;
  final String contactImage;
  final String groupId;

  const ChatScreen({
    super.key,
    required this.contactUID,
    required this.contactName,
    required this.contactImage,
    required this.groupId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // Değişkenleri widget üzerinden alıyoruz
    final contactUID = widget.contactUID;
    final contactName = widget.contactName;
    final contactImage = widget.contactImage;
    final groupId = widget.groupId;

    final isGroupChat = groupId.isNotEmpty;

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: isGroupChat
            ? GroupChatAppBar(groupId: groupId)
            : ChatAppBar(contactUID: contactUID),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ChatList(
                contactUID: contactUID,
                groupId: groupId,
              ),
            ),
            BottomChatField(
              contactUID: contactUID,
              contactName: contactName,
              contactImage: contactImage,
              groupId: groupId,
            ),
          ],
        ),
      ),
    );
  }
}
