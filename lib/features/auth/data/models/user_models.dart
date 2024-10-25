// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String? email;
  final String? photoUrl;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.photoUrl,
  });
  factory UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    return UserModel(
      userId: snapshot.get('user_id'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      photoUrl: snapshot.get('photo_url'),
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'email': email,
        'photo_url': photoUrl,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photo_url'],
    );
  }
}
