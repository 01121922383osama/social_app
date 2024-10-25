import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/features/home/data/models/post.dart';
import 'package:social_app/features/home/domain/repositories/post_repo.dart';

class GetAllPostUseCase {
  final PostRepo _postRepo;
  GetAllPostUseCase({required PostRepo postRepo}) : _postRepo = postRepo;

  Future<Either<FialureServer, List<PostModel>>> call() async {
    return await _postRepo.getAllPost();
  }
}
