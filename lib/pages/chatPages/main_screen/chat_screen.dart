import 'package:ServXFactory/pages/chatPages/main_screen/call_screen.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/models/call_model.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/providers/authentication_provider.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/botton_chat_field.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/chat_app_bar.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/chat_list.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/widgets/group_chat_app_bar.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/incoming_call_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String contactUID; // Karşı tarafın kullanıcı ID'si
  final String contactName; // Karşı tarafın adı
  final String contactImage; // Karşı tarafın profil fotoğrafı
  final String groupId; // Grup sohbeti için grup ID'si (boşsa bireysel sohbet)

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
  @override
  void initState() {
    super.initState();
    listenForIncomingCalls();
  }

  /// **Gelen Çağrıları Dinle**
  void listenForIncomingCalls() {
    FirebaseFirestore.instance
        .collection('calls')
        .where('receiverId',
            isEqualTo: context.read<AuthenticationProvider>().userModel!.id)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final callData = snapshot.docs.first.data();
        final call = CallModel.fromMap(callData);

        if (call.status == 'ringing') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IncomingCallScreen(call: call),
            ),
          );
        }
      }
    });
  }

  void listenForOutgoingCall(String callId) {
    FirebaseFirestore.instance
        .collection('calls')
        .doc(callId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final callData = snapshot.data()!;
        final call = CallModel.fromMap(callData);

        if (call.status == 'active') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(
                appId: '1774071043',
                appSign:
                    '4d90f2b1d71bbc86a1e8f8381fd2c08d6923692f85e6f6af185c9d93951d13e0',
                userId: call.callerId,
                userName: call.callerName,
                callId: callId,
                isVideoCall: call.hasVideo,
              ),
            ),
          );
        } else if (call.status == 'ended') {
          Navigator.pop(context); // Çağrı sonlandırıldı
        }
      }
    });
  }

  /// **Firebase'e Çağrı Loglama**
  void logCallToFirebase(CallModel call) async {
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(call.callId)
        .set(call.toMap());
  }

  /// **Sesli veya Görüntülü Arama Başlat**
  Future<void> startZegoCall({
    required String callId,
    required bool isVideoCall,
    required String callerName,
    required String callerId,
  }) async {
    final call = CallModel(
      callId: callId,
      callerId: callerId,
      callerName: callerName,
      receiverId: widget.contactUID,
      receiverName: widget.contactName,
      hasVideo: isVideoCall,
      status: 'ringing',
      timestamp: DateTime.now(),
    );

    await FirebaseFirestore.instance
        .collection('calls')
        .doc(call.callId)
        .set(call.toMap());
    listenForOutgoingCall(callId); // Dinleyici ekle
  }

  @override
  Widget build(BuildContext context) {
    final isGroupChat = widget.groupId.isNotEmpty;
    final uid = context.read<AuthenticationProvider>().userModel!.id;
    final name = context.read<AuthenticationProvider>().userModel!.name;

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              startZegoCall(
                callerName: name,
                callerId: uid,
                callId: DateTime.now().millisecondsSinceEpoch.toString(),
                isVideoCall: false,
              );
            },
            tooltip: 'Sesli Arama',
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              startZegoCall(
                callerName: name,
                callerId: uid,
                callId: DateTime.now().millisecondsSinceEpoch.toString(),
                isVideoCall: true,
              );
            },
            tooltip: 'Görüntülü Arama',
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: isGroupChat
            ? GroupChatAppBar(groupId: widget.groupId)
            : ChatAppBar(contactUID: widget.contactUID),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ChatList(
                contactUID: widget.contactUID,
                groupId: widget.groupId,
              ),
            ),
            BottomChatField(
              contactUID: widget.contactUID,
              contactName: widget.contactName,
              contactImage: widget.contactImage,
              groupId: widget.groupId,
            ),
          ],
        ),
      ),
    );
  }
}
