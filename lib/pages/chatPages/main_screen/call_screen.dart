import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatelessWidget {
  final String appId; // ZEGOCLOUD App ID
  final String appSign; // ZEGOCLOUD App Sign
  final String userId; // Oturum açmış kullanıcının benzersiz ID'si
  final String userName; // Kullanıcı adı
  final String callId; // Çağrı için benzersiz bir ID
  final bool isVideoCall;

  const CallScreen({
    super.key,
    required this.appId,
    required this.appSign,
    required this.userId,
    required this.userName,
    required this.callId,
    required this.isVideoCall,
  });

  @override
  void endCall(String callId) async {
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(callId)
        .update({'status': 'ended'});
  }

  Future<void> deleteCallsCollection() async {
    try {
      // 'calls' koleksiyonundaki tüm belgeleri al
      final querySnapshot =
          await FirebaseFirestore.instance.collection('calls').get();

      for (var doc in querySnapshot.docs) {
        // Her belgeyi sil
        await doc.reference.delete();
        print("Deleted call document with ID: ${doc.id}");
      }

      print("All documents in 'calls' collection have been deleted.");
    } catch (e) {
      print("Error deleting calls collection: $e");
    }
  }

  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: int.parse(appId), // App ID (int formatında)
      appSign: appSign, // App Sign (string formatında)
      userID: userId, // Kullanıcının ID'si
      userName: userName, // Kullanıcının adı
      callID: callId, // Çağrı için benzersiz bir ID
      onDispose: () {
        endCall(callId);
        deleteCallsCollection();
      },

      config: isVideoCall
          ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
