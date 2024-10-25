import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/features/home/data/models/post.dart';
import 'package:social_app/features/home/domain/repositories/post_repo.dart';

class UploadPostUsecase {
  final PostRepo _postRepo;
  UploadPostUsecase({
    required PostRepo postRepo,
  }) : _postRepo = postRepo;

  Future<Either<FialureServer, PostModel>> call(
      {required PostModel post}) async {
    return await _postRepo.uploadPost(post: post);
  }
}
