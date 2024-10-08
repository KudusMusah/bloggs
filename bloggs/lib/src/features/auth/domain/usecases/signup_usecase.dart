import 'package:bloggs/src/features/auth/domain/entities/user_entity.dart';
import 'package:bloggs/src/features/auth/domain/repository/auth_respository.dart';
import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUsecase implements Usecase<User, SignUpParams> {
  final AuthRespository authRepository;
  UserSignUpUsecase({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      params.email,
      params.password,
      params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String name;

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
