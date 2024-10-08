import 'package:fpdart/fpdart.dart';

import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:bloggs/src/core/common/entities/user_entity.dart';
import 'package:bloggs/src/features/auth/domain/repository/auth_respository.dart';

class LoggedInUserUsecase implements Usecase<User, NoParams> {
  final AuthRespository authRespository;
  LoggedInUserUsecase({
    required this.authRespository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRespository.getLoggedInUser();
  }
}
