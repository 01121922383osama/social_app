import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/features/home/data/models/post.dart';

abstract class PostRepo {
  Future<Either<FialureServer, PostModel>> uploadPost(
      {required PostModel post});
  Future<Either<FialureServer, List<PostModel>>> getAllPost();
}
