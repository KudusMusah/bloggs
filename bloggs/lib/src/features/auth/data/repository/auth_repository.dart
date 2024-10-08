// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloggs/src/core/error/exception.dart';
import 'package:bloggs/src/features/auth/data/models/user_model.dart';
import 'package:fpdart/src/either.dart';

import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bloggs/src/features/auth/domain/repository/auth_respository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRespository {
  final AuthRemoteDataSourceImpl authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> loginUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final res =
          await authRemoteDataSource.loginUpWithEmailPassword(email, password);
      return right(res);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final res = await authRemoteDataSource.signUpWithEmailPassword(
        email,
        password,
        name,
      );
      return right(res);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
