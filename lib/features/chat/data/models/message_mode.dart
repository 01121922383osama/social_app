// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String sendId;
  final String message;
  final DateTime timeSpam;
  MessageModel({
    required this.sendId,
    required this.message,
    required this.timeSpam,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sendId': sendId,
      'message': message,
      'timeSpam': timeSpam.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      sendId: map['sendId'] as String,
      message: map['message'] as String,
      timeSpam: DateTime.fromMillisecondsSinceEpoch(map['timeSpam'] as int),
    );
  }
}
