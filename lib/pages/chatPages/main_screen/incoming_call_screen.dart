import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/models/call_model.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/call_screen.dart';

class IncomingCallScreen extends StatelessWidget {
  final CallModel call;
  void acceptCall(String callId) async {
    await FirebaseFirestore.instance
        .collection('calls')
        .doc(callId)
        .update({'status': 'active'});
  }

  const IncomingCallScreen({super.key, required this.call});

  @override
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
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              'Gelen Çağrı: ${call.callerName}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    acceptCall(call.callId);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallScreen(
                          appId: '1774071043',
                          appSign:
                              '4d90f2b1d71bbc86a1e8f8381fd2c08d6923692f85e6f6af185c9d93951d13e0',
                          userId: call.receiverId,
                          userName: call.receiverName,
                          callId: call.callId,
                          isVideoCall: call.hasVideo,
                        ),
                      ),
                    );
                  },
                  child: const Text('Kabul Et'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('calls')
                        .doc(call.callId)
                        .update({'status': 'ended'});

                    deleteCallsCollection();
                    Navigator.pop(context);
                  },
                  child: const Text('Reddet'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
