import 'package:ServXFactory/models/userModel.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/profile_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/utilities/global_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key, required this.contactUID});

  final String contactUID;

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context
          .read<AuthenticationProvider>()
          .userStream(userID: widget.contactUID),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data?.data() == null) {
          return const Center(child: Text('User data not found'));
        }

        final userModel =
            UserModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);
        print("userModel.lastSeen: ${userModel.lastSeen}");

        // Güvenli bir şekilde lastSeen değerini kontrol et
        DateTime? lastSeen;
        try {
          lastSeen = DateTime.fromMillisecondsSinceEpoch(
              int.parse(userModel.lastSeen));
        } catch (e) {
          print("Invalid lastSeen value: ${userModel.lastSeen}");
        }

        return Row(
          children: [
            userImageWidget(
              imageUrl: userModel.image,
              radius: 20,
              onTap: () {
                // Kullanıcının profil ekranına git
                // Navigator.pushNamed(
                //   context,
                //   '/profileScreen',
                //   arguments: userModel.id,
                // );
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen(userId: userModel.id);
                }));
              },
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
                Text(
                  userModel.isOnline
                      ? 'Online'
                      : lastSeen != null
                          ? 'Last seen ${timeago.format(lastSeen)}'
                          : 'Last seen unknown',
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: userModel.isOnline
                        ? Colors.green
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}



// import 'package:ServXFactory/models/userModel.dart';
// import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
// import 'package:ServXFactory/pages/chatPages/main_screen/utilities/global_methods.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class ChatAppBar extends StatefulWidget {
//   const ChatAppBar({super.key, required this.contactUID});

//   final String contactUID;

//   @override
//   State<ChatAppBar> createState() => _ChatAppBarState();
// }

// class _ChatAppBarState extends State<ChatAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: context
//           .read<AuthenticationProvider>()
//           .userStream(userID: widget.contactUID),
//       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text('Something went wrong'));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final userModel =
//             UserModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);
//         print("userModel.lastSeen: ${userModel.lastSeen}");

//         DateTime lastSeen =
//             DateTime.fromMillisecondsSinceEpoch(int.parse(userModel.lastSeen));

//         return Row(
//           children: [
//             userImageWidget(
//               imageUrl: userModel.image,
//               radius: 20,
//               onTap: () {
//                 // navigate to this friends profile with uid as argument
//                 Navigator.pushNamed(context, '/profileScreen',
//                     arguments: userModel.id);
//               },
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   userModel.name,
//                   style: GoogleFonts.openSans(
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   userModel.isOnline
//                       ? 'Online'
//                       : 'Last seen ${timeago.format(lastSeen)}',
//                   style: GoogleFonts.openSans(
//                     fontSize: 12,
//                     color: userModel.isOnline
//                         ? Colors.green
//                         : Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
