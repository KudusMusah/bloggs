import 'dart:io';

import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';
import 'package:bloggs/src/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements Usecase<BlogEntity, BlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, BlogEntity>> call(BlogParams params) {
    return blogRepository.uploadBlog(
      params.posterId,
      params.title,
      params.content,
      params.image,
      params.categories,
    );
  }
}

class BlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> categories;

  BlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
  });
}
