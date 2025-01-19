import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/chat_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/streams/chats_stream.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/streams/search_stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_pro/models/last_message_model.dart';
// import 'package:flutter_chat_pro/widgets/chat_widget.dart';
import 'package:provider/provider.dart';

class MyChatsScreen extends StatefulWidget {
  const MyChatsScreen({super.key});

  @override
  State<MyChatsScreen> createState() => _MyChatsScreenState();
}

class _MyChatsScreenState extends State<MyChatsScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthenticationProvider>().userModel!.id;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return Column(
            children: [
              // cupertinosearchbar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: CupertinoSearchTextField(
                  // placeholder: 'Search',
                  placeholder: 'Ara',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  onChanged: (value) {
                    chatProvider.setSearchQuery(value);
                  },
                ),
              ),
              Expanded(
                child: chatProvider.searchQuery.isEmpty
                    ? ChatsStream(uid: uid)
                    : SearchStream(uid: uid),
              ),
            ],
          );
        },
      ),
    );
  }
}
