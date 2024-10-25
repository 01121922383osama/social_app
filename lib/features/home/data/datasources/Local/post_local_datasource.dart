import 'package:hive/hive.dart';
import 'package:social_app/core/constant/app_strings.dart';
import 'package:social_app/features/home/data/models/post.dart';

abstract class PostLocalDatasource {
  List<PostModel> getAllPost();
}

class PostLocalDatasourceImpl implements PostLocalDatasource {
  @override
  List<PostModel> getAllPost() {
    final data = Hive.box<PostModel>(AppStrings.postHiveBox);
    return data.values.toList();
  }
}
