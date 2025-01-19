// import 'package:flutter_chat_pro/enums/enums.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/enums/enums.dart';

class MessageModel {
  final String senderUID;
  final String senderName;
  final String senderImage;
  final String contactUID;
  final String message;
  final MessageEnum messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  final List<String> reactions;
  final List<String> isSeenBy;
  final List<String> deletedBy;

  MessageModel({
    required this.senderUID,
    required this.senderName,
    required this.senderImage,
    required this.contactUID,
    required this.message,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.reactions,
    required this.isSeenBy,
    required this.deletedBy,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'senderUID': senderUID,
      'senderName': senderName,
      'senderImage': senderImage,
      'contactUID': contactUID,
      'message': message,
      'messageType': messageType.name,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.name,
      'reactions': reactions,
      'isSeenBy': isSeenBy,
      'deletedBy': deletedBy,
    };
  }

  // from map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderUID: map['senderUID'] ?? '',
      senderName: map['senderName'] ?? '',
      senderImage: map['senderImage'] ?? '',
      contactUID: map['contactUID'] ?? '',
      message: map['message'] ?? '',
      messageType: map['messageType'].toString().toMessageEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      repliedMessage: map['repliedMessage'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      repliedMessageType: map['repliedMessageType'].toString().toMessageEnum(),
      reactions: List<String>.from(map['reactions'] ?? []),
      isSeenBy: List<String>.from(map['isSeenBy'] ?? []),
      deletedBy: List<String>.from(map['deletedBy'] ?? []),
    );
  }

  copyWith({required String userId}) {
    return MessageModel(
      senderUID: senderUID,
      senderName: senderName,
      senderImage: senderImage,
      contactUID: userId,
      message: message,
      messageType: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: isSeen,
      repliedMessage: repliedMessage,
      repliedTo: repliedTo,
      repliedMessageType: repliedMessageType,
      reactions: reactions,
      isSeenBy: isSeenBy,
      deletedBy: deletedBy,
    );
  }
}
