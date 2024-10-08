import 'package:bloggs/src/core/common/entities/user_entity.dart';
import 'package:bloggs/src/features/auth/domain/repository/auth_respository.dart';
import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInUsecase implements Usecase<User, SignInParams> {
  final AuthRespository authRepository;
  UserSignInUsecase({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await authRepository.loginUpWithEmailPassword(
      params.email,
      params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
