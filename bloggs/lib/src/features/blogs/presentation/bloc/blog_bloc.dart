import 'dart:io';

import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';
import 'package:bloggs/src/features/blogs/domain/usecases/get_all_blogs_usecase.dart';
import 'package:bloggs/src/features/blogs/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_state.dart';
part 'blog_event.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;

  BlogBloc({
    required UploadBlogUsecase uploadBlogUsecase,
    required GetAllBlogsUsecase getAllBlogsUsecase,
  })  : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUsecase = getAllBlogsUsecase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<AddBlogEvent>(_onAddBlog);
    on<GetAllBlogsEvent>(_onGetAllBlogs);
  }

  void _onAddBlog(AddBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUsecase(
      BlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        categories: event.categories,
        image: event.image,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogSuccess()),
    );
  }

  void _onGetAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUsecase(NoParams());

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(GetAllBlogsSuccess(r.reversed.toList())),
    );
  }
}
