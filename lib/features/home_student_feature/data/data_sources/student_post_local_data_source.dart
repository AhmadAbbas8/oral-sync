import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/features/home_student_feature/data/models/Student_post_model.dart';

abstract class StudentPostLocalDataSource {
  Future<List<StudentPostModel>> getCachedPosts();

  Future<Unit> cachedPosts(List<StudentPostModel> posts);
}

class StudentPostLocalDataSourceImpl implements StudentPostLocalDataSource {
  final CacheStorage cacheStorage;

  StudentPostLocalDataSourceImpl({required this.cacheStorage});

  @override
  Future<Unit> cachedPosts(List<StudentPostModel> posts) async {
    List model = posts.map((e) => e.toJson()).toList();
    await cacheStorage.setData(
        key: SharedPrefsKeys.studentPostsCached, value: json.encode(model));
    return Future.value(unit);
  }

  @override
  Future<List<StudentPostModel>> getCachedPosts() async {
    var postsJson =
        cacheStorage.getData(key: SharedPrefsKeys.studentPostsCached);
    if (postsJson != null) {
      List posts = json.decode(postsJson);
      return posts.map((e) => StudentPostModel.fromJson(e)).toList();
    } else {
      throw EmptyCacheException();
    }
  }
}
