// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:social_app/features/chat/data/models/message_mode.dart';

class ChatModel {
  final String chatId;
  final List<String> members;
  final MessageModel lastMessage;
  final DateTime lastUpdate;
  ChatModel({
    required this.chatId,
    required this.members,
    required this.lastMessage,
    required this.lastUpdate,
  });

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] as String,
      members: List<String>.from((map['members'] as List<String>)),
      lastMessage:
          MessageModel.fromJson(map['lastMessage'] as Map<String, dynamic>),
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(map['lastUpdate'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'chatId': chatId,
      'members': members,
      'lastMessage': lastMessage.toJson(),
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
    };
  }
}
