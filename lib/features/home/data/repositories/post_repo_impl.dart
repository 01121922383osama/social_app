import 'package:fpdart/fpdart.dart';
import 'package:social_app/core/error/fialure_server.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/core/network/network.dart';
import 'package:social_app/features/home/data/datasources/Local/post_local_datasource.dart';
import 'package:social_app/features/home/data/datasources/Remote/post_remote_data_soarce.dart';
import 'package:social_app/features/home/data/models/post.dart';

import '../../domain/repositories/post_repo.dart';

class PostRepoImpl implements PostRepo {
  final PostRemoteDataSoarce _postRemoteDataSoarce;
  final PostLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  PostRepoImpl({
    required PostRemoteDataSoarce postRemoteDataSoarce,
    required NetworkInfo networkInfo,
    required PostLocalDatasource localDatasource,
  })  : _postRemoteDataSoarce = postRemoteDataSoarce,
        _localDatasource = localDatasource,
        _networkInfo = networkInfo;
  @override
  Future<Either<FialureServer, PostModel>> uploadPost(
      {required PostModel post}) async {
    try {
      final newPost = await _postRemoteDataSoarce.uploadPost(post: post);
      return Right(newPost);
    } on ServerException catch (e) {
      return Left(FialureServer(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<FialureServer, List<PostModel>>> getAllPost() async {
    final remote = await _postRemoteDataSoarce.getAllPost();
    final local = _localDatasource.getAllPost();
    try {
      if (await _networkInfo.isConnected) {
        return Right(remote);
      } else {
        return Right(local);
      }
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }
}
