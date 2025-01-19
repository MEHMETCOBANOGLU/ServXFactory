import 'package:ServXFactory/pages/chatPages/main_screen/enums/enums.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/app_bar_back_button.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/friends_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_pro/enums/enums.dart';
// import 'package:flutter_chat_pro/widgets/app_bar_back_button.dart';
// import 'package:flutter_chat_pro/widgets/friends_list.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Friends'),
      ),
      body: Column(
        children: [
          // cupertinosearchbar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              // placeholder: 'Search',
              placeholder: 'Ara',
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                print(value);
              },
            ),
          ),

          const Expanded(
              child: Padding(
            padding: EdgeInsets.only(bottom: 1.0),
            child: FriendsList(
              viewType: FriendViewType.friends,
            ),
          )),
        ],
      ),
    );
  }
}
