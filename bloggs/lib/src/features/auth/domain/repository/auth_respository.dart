import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRespository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  );

  Future<Either<Failure, User>> loginUpWithEmailPassword(
    String email,
    String password,
  );
}
