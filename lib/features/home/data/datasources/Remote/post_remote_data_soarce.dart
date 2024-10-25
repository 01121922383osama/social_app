import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:social_app/core/constant/app_strings.dart';
import 'package:social_app/features/home/data/models/post.dart';

import '../../../../../core/error/server_exception.dart';

abstract class PostRemoteDataSoarce {
  Future<PostModel> uploadPost({required PostModel post});
  Future<List<PostModel>> getAllPost();
}

class PostRemoteDataSoarceImpl implements PostRemoteDataSoarce {
  final FirebaseFirestore _firestore;

  PostRemoteDataSoarceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  @override
  Future<PostModel> uploadPost({required PostModel post}) async {
    try {
      final newPost = PostModel(
        id: post.id,
        name: post.name,
        postDate: post.postDate,
        userImage: post.userImage,
        description: post.description,
        imagePost: post.imagePost,
        likes: post.likes,
      );
      await _firestore.collection('post').doc(post.id).set(post.toMap());
      return newPost;
    } on FirebaseException catch (e) {
      throw ServerException(errorMessage: e.message!);
    }
  }

  @override
  Future<List<PostModel>> getAllPost() async {
    try {
      final postData = await _firestore.collection('post').get();
      final List<PostModel> data = postData.docs.map((value) {
        return PostModel.toDocs(value);
      }).toList();
      final box = Hive.box<PostModel>(AppStrings.postHiveBox);
      box.clear();
      for (var post in data) {
        box.put(post.id, post);
      }
      return data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
