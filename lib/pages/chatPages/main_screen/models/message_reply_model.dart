// import 'package:flutter_chat_pro/enums/enums.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/enums/enums.dart';

class MessageReplyModel {
  final String message;
  final String senderUID;
  final String senderName;
  final String senderImage;
  final MessageEnum messageType;
  final bool isMe;

  MessageReplyModel({
    required this.message,
    required this.senderUID,
    required this.senderName,
    required this.senderImage,
    required this.messageType,
    required this.isMe,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderUID': senderUID,
      'senderName': senderName,
      'senderImage': senderImage,
      'messageType': messageType.name,
      'isMe': isMe,
    };
  }

  // from map
  factory MessageReplyModel.fromMap(Map<String, dynamic> map) {
    return MessageReplyModel(
      message: map['message'] ?? '',
      senderUID: map['senderUID'] ?? '',
      senderName: map['senderName'] ?? '',
      senderImage: map['senderImage'] ?? '',
      messageType: map['messageType'].toString().toMessageEnum(),
      isMe: map['isMe'] ?? false,
    );
  }
}
