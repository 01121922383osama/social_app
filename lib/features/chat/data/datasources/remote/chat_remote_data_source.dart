import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/constant/app_strings.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/chat/data/models/message_mode.dart';

abstract class ChatRemoteDataSource {
  Stream<List<UserModel>> getUsers();
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  });
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  });
  Stream<List<MessageModel>> getMessages({
    required String chatId,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;

  ChatRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  }) async {
    final snapchot = await _firestore
        .collection(AppStrings.chatFireStoreKey)
        .where(
          'members',
          arrayContains: userId1,
        )
        .get();

    for (var docs in snapchot.docs) {
      if (docs.data()['members'].contains(userId2)) {
        return docs.id;
      }
    }
    final chatDoc =
        await _firestore.collection(AppStrings.chatFireStoreKey).add({
      'members': [userId1, userId2],
      'lastMessage': '',
      'lastUpdate': FieldValue.serverTimestamp(),
    });
    return chatDoc.id;
  }

  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return _firestore
        .collection(AppStrings.chatFireStoreKey)
        .doc(chatId)
        .collection(AppStrings.mesagesFireStoreKey)
        .orderBy('timeSpam', descending: true)
        .snapshots()
        .map((snapchot) => snapchot.docs.map((docs) {
              final message = MessageModel.fromJson(docs.data());
              return message;
            }).toList());
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return _firestore
        .collection(AppStrings.userFireStoreKey)
        .snapshots()
        .map((snapchot) => snapchot.docs.map((docs) {
              return UserModel.fromMap(docs.data());
            }).where((user) {
              return user.email != FirebaseAuth.instance.currentUser!.email;
            }).toList());
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    await _firestore
        .collection(AppStrings.chatFireStoreKey)
        .doc(chatId)
        .collection(AppStrings.mesagesFireStoreKey)
        .add(message.toJson());
  }
}
