part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogFailure extends BlogState {
  final String message;
  BlogFailure({
    required this.message,
  });
}

class BlogSuccess extends BlogState {}

class GetAllBlogsSuccess extends BlogState {
  final List<BlogEntity> blogs;

  GetAllBlogsSuccess(this.blogs);
}
