import 'dart:io';

import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog(
    String posterId,
    String title,
    String content,
    File image,
    List<String> categories,
  );

  Future<Either<Failure, List<BlogEntity>>> geAllBlogs();
}
