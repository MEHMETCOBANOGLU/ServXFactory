// import 'package:flutter_chat_pro/enums/enums.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/enums/enums.dart';

class LastMessageModel {
  String senderUID;
  String contactUID;
  String contactName;
  String contactImage;
  String message;
  MessageEnum messageType;
  DateTime timeSent;
  bool isSeen;

  LastMessageModel({
    required this.senderUID,
    required this.contactUID,
    required this.contactName,
    required this.contactImage,
    required this.message,
    required this.messageType,
    required this.timeSent,
    required this.isSeen,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'senderUID': senderUID,
      'contactUID': contactUID,
      'contactName': contactName,
      'contactImage': contactImage,
      'message': message,
      'messageType': messageType.name,
      'timeSent': timeSent.microsecondsSinceEpoch,
      'isSeen': isSeen,
    };
  }

  // from map
  factory LastMessageModel.fromMap(Map<String, dynamic> map) {
    return LastMessageModel(
      senderUID: map['senderUID'] ?? '',
      contactUID: map['contactUID'] ?? '',
      contactName: map['contactName'] ?? '',
      contactImage: map['contactImage'] ?? '',
      message: map['message'] ?? '',
      messageType: map['messageType'].toString().toMessageEnum(),
      timeSent: DateTime.fromMicrosecondsSinceEpoch(map['timeSent']),
      isSeen: map['isSeen'] ?? false,
    );
  }

  copyWith({
    required String contactUID,
    required String contactName,
    required String contactImage,
  }) {
    return LastMessageModel(
      senderUID: senderUID,
      contactUID: contactUID,
      contactName: contactName,
      contactImage: contactImage,
      message: message,
      messageType: messageType,
      timeSent: timeSent,
      isSeen: isSeen,
    );
  }
}
