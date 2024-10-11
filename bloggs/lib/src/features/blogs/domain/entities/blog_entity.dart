// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogEntity {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final List<String> categories;
  final String imageUrl;
  final DateTime updatedAt;
  final String? posterName;

  BlogEntity({
    this.posterName,
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.categories,
    required this.imageUrl,
    required this.updatedAt,
  });
}
