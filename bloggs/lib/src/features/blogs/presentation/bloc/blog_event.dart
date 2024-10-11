part of 'blog_bloc.dart';

sealed class BlogEvent {}

class AddBlogEvent extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> categories;

  AddBlogEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
  });
}

class GetAllBlogsEvent extends BlogEvent {}
