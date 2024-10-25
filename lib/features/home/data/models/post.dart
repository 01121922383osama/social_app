import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'post.g.dart';

@HiveType(typeId: 0)
class PostModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String userImage;
  @HiveField(4)
  final String? imagePost;
  @HiveField(5)
  final DateTime postDate;
  @HiveField(6)
  final List<dynamic>? likes;

  PostModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.userImage,
    this.imagePost,
    required this.postDate,
    this.likes,
  });
  factory PostModel.toDocs(DocumentSnapshot snapshot) {
    return PostModel(
      id: snapshot.get('id'),
      name: snapshot.get('name'),
      postDate: (snapshot.get('postDate') as Timestamp).toDate(),
      userImage: snapshot.get('userImage'),
      description: snapshot.get('description'),
      imagePost: snapshot.get('imagePost'),
      likes: snapshot.get('likes'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'postDate': postDate,
      'userImage': userImage,
      'description': description,
      'imagePost': imagePost,
      'likes': likes,
    };
  }
}
