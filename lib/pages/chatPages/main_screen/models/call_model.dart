class CallModel {
  final String callId;
  final String callerId;
  final String callerName;
  final String receiverId;
  final String receiverName;
  final bool hasVideo;
  final String status; // 'ringing', 'active', 'ended'
  final DateTime timestamp;

  CallModel({
    required this.callId,
    required this.callerId,
    required this.callerName,
    required this.receiverId,
    required this.receiverName,
    required this.hasVideo,
    required this.status,
    required this.timestamp,
  });

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      callId: map['callId'],
      callerId: map['callerId'],
      callerName: map['callerName'],
      receiverId: map['receiverId'],
      receiverName: map['receiverName'],
      hasVideo: map['hasVideo'],
      status: map['status'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'callId': callId,
      'callerId': callerId,
      'callerName': callerName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'hasVideo': hasVideo,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
