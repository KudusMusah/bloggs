import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';
import 'package:bloggs/src/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUsecase implements Usecase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogsUsecase({required this.blogRepository});

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.geAllBlogs();
  }
}
