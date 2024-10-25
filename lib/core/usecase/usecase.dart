import 'package:fpdart/fpdart.dart';
import '../error/fialure_server.dart';

abstract class UseCase<T, Params> {
  Future<Either<FialureServer, T>> call({Params? param});
}
