// import 'package:flutter_chat_pro/enums/enums.dart';
import 'package:ServXFactory/pages/chatPages/main_screen/enums/enums.dart';

class GroupModel {
  String creatorUID;
  String groupName;
  String groupDescription;
  String groupImage;
  String groupId;
  String lastMessage;
  String senderUID;
  MessageEnum messageType;
  String messageId;
  DateTime timeSent;
  DateTime createdAt;
  bool isPrivate;
  bool editSettings;
  bool approveMembers;
  bool lockMessages;
  bool requestToJoing;
  List<String> membersUIDs;
  List<String> adminsUIDs;
  List<String> awaitingApprovalUIDs;

  GroupModel({
    required this.creatorUID,
    required this.groupName,
    required this.groupDescription,
    required this.groupImage,
    required this.groupId,
    required this.lastMessage,
    required this.senderUID,
    required this.messageType,
    required this.messageId,
    required this.timeSent,
    required this.createdAt,
    required this.isPrivate,
    required this.editSettings,
    required this.approveMembers,
    required this.lockMessages,
    required this.requestToJoing,
    required this.membersUIDs,
    required this.adminsUIDs,
    required this.awaitingApprovalUIDs,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'creatorUID': creatorUID,
      'groupName': groupName,
      'groupDescription': groupDescription,
      'groupImage': groupImage,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'senderUID': senderUID,
      'messageType': messageType.name,
      'messageId': messageId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isPrivate': isPrivate,
      'editSettings': editSettings,
      'approveMembers': approveMembers,
      'lockMessages': lockMessages,
      'requestToJoing': requestToJoing,
      'membersUIDs': membersUIDs,
      'adminsUIDs': adminsUIDs,
      'awaitingApprovalUIDs': awaitingApprovalUIDs,
    };
  }

  // from map
  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      creatorUID: map['creatorUID'] ?? '',
      groupName: map['groupName'] ?? '',
      groupDescription: map['groupDescription'] ?? '',
      groupImage: map['groupImage'] ?? '',
      groupId: map['groupId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      senderUID: map['senderUID'] ?? '',
      messageType: map['messageType'].toString().toMessageEnum(),
      messageId: map['messageId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(
          map['timeSent'] ?? DateTime.now().millisecondsSinceEpoch),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch),
      isPrivate: map['isPrivate'] ?? false,
      editSettings: map['editSettings'] ?? false,
      approveMembers: map['approveMembers'] ?? false,
      lockMessages: map['lockMessages'] ?? false,
      requestToJoing: map['requestToJoing'] ?? false,
      membersUIDs: List<String>.from(map['membersUIDs'] ?? []),
      adminsUIDs: List<String>.from(map['adminsUIDs'] ?? []),
      awaitingApprovalUIDs:
          List<String>.from(map['awaitingApprovalUIDs'] ?? []),
    );
  }
}
