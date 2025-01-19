import 'package:ServXFactory/pages/chatPages/main_screen/private_group_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/public_group_screen.dart';
import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              // indicatorSize: TabBarIndicatorSize.label,

              tabs: [
                Tab(
                  text: 'private'.toUpperCase(),
                ),
                Tab(
                  text: 'public'.toUpperCase(),
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            PrivateGroupScreen(),
            PublicGroupScreen(),
          ]),
        ));
  }
}
