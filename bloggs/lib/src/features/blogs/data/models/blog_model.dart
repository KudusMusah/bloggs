import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    super.posterName,
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.categories,
    required super.imageUrl,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'categories': categories,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      categories: List<String>.from(map['categories'] as List<dynamic>),
      imageUrl: map['image_url'] as String,
      updatedAt: DateTime.parse(map["updated_at"]),
    );
  }

  BlogModel copyWith(
      {String? id,
      String? posterId,
      String? title,
      String? content,
      List<String>? categories,
      String? imageUrl,
      DateTime? updatedAt,
      String? posterName}) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      categories: categories ?? this.categories,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
