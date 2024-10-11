import 'package:bloggs/src/features/blogs/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDatasource {
  List<BlogModel> getLocalBlogs();
  void uploadLocalBlogs(List<BlogModel> blogs);
}

class BlogLocalDatasourceImpl implements BlogLocalDatasource {
  final Box box;

  BlogLocalDatasourceImpl({required this.box});

  @override
  List<BlogModel> getLocalBlogs() {
    final List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get("Blog $i")));
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs(blogs) {
    box.clear();

    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put("Blog $i", blogs[i].toJson());
      }
    });
  }
}
