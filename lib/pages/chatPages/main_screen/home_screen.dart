import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/create_group_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/groups_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/my_chats_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/people_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/profile_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/group_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/utilities/global_methods.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/app_bar_back_button.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/profile_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  final List<Widget> pages = const [
    MyChatsScreen(),
    GroupsScreen(),
    PeopleScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // user comes back to the app
        // update user status to online
        context.read<AuthenticationProvider>().updateUserStatus(
              value: true,
            );
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // app is inactive, paused, detached or hidden
        // update user status to offline
        context.read<AuthenticationProvider>().updateUserStatus(
              value: false,
            );
        break;
      default:
        // handle other states
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('KSP Sohbet'),
          leading: AppBarBackButton(onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: userImageWidget(
                imageUrl: authProvider.userModel?.image ??
                    'assets/images/user_icon.png',
                radius: 20,
                onTap: () {
                  // navigate to user profile with uis as arguments
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                userId: authProvider.userModel!.id,
                              )));
                  // Navigator.pushNamed(
                  //   context,
                  //   Constants.profileScreen,
                  //   arguments: authProvider.userModel!.id,
                  // );
                },
              ),
            )
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: pages,
        ),
        floatingActionButton: currentIndex == 1
            ? FloatingActionButton(
                backgroundColor: AppTheme.lightTheme.secondaryHeaderColor,
                foregroundColor: AppTheme.lightTheme.colorScheme.primary,
                onPressed: () {
                  context
                      .read<GroupProvider>()
                      .clearGroupMembersList()
                      .whenComplete(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateGroupScreen(),
                      ),
                    );
                  });
                },
                child: const Icon(CupertinoIcons.add),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              // label: 'Chats',
              label: 'Sohbetler',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.group),
              // label: 'Groups',
              label: 'Gruplar',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.globe),
              // label: 'People',
              label: 'Kişiler',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            // animate to the page
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
