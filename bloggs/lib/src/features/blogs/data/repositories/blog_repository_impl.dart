// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:bloggs/src/core/error/exception.dart';
import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/network/internet_connection.dart';
import 'package:bloggs/src/features/blogs/data/datasources/blog_local_datasource.dart';
import 'package:bloggs/src/features/blogs/data/datasources/blog_remote_datasource.dart';
import 'package:bloggs/src/features/blogs/data/models/blog_model.dart';
import 'package:bloggs/src/features/blogs/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;
  final BlogLocalDatasource blogLocalDatasource;
  final InternetConnectionChecker internetConnection;

  BlogRepositoryImpl({
    required this.blogRemoteDatasource,
    required this.blogLocalDatasource,
    required this.internetConnection,
  });

  @override
  Future<Either<Failure, BlogModel>> uploadBlog(
    String posterId,
    String title,
    String content,
    File image,
    List<String> categories,
  ) async {
    if (!await (internetConnection.hasInternectConnection)) {
      return left(Failure("No network connection"));
    }
    try {
      BlogModel blog = BlogModel(
        id: const Uuid().v4(),
        posterId: posterId,
        title: title,
        content: content,
        categories: categories,
        imageUrl: "",
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDatasource.uploadImage(image, blog);

      blog = blog.copyWith(
        imageUrl: imageUrl,
      );
      final blogData = await blogRemoteDatasource.uploadBlog(blog);
      return right(blogData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> geAllBlogs() async {
    try {
      if (!await (internetConnection.hasInternectConnection)) {
        return right(blogLocalDatasource.getLocalBlogs());
      }
      final blogs = await blogRemoteDatasource.getAllBlogs();
      blogLocalDatasource.uploadLocalBlogs(blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
