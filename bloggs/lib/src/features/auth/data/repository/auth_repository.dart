import 'package:fpdart/fpdart.dart';
import 'package:bloggs/src/core/error/exception.dart';
import 'package:bloggs/src/core/error/failure.dart';
import 'package:bloggs/src/core/network/internet_connection.dart';
import 'package:bloggs/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bloggs/src/features/auth/data/models/user_model.dart';
import 'package:bloggs/src/features/auth/domain/repository/auth_respository.dart';

class AuthRepositoryImpl implements AuthRespository {
  final AuthRemoteDatasource authRemoteDataSource;
  final InternetConnectionChecker internetConnection;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.internetConnection,
  });

  @override
  Future<Either<Failure, UserModel>> getLoggedInUser() async {
    try {
      if (!await (internetConnection.hasInternectConnection)) {
        final userSession = authRemoteDataSource.getCurrentUserSession;
        if (userSession == null) {
          return left(Failure("User is not logged In"));
        }
        final user = userSession.user;
        return right(
          UserModel(
            id: user.id,
            email: user.email ?? "",
            name: "",
          ),
        );
      }
      final user = await authRemoteDataSource.getLoggedInUser();

      if (user == null) {
        return left(Failure("User is not logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginUpWithEmailPassword(
    String email,
    String password,
  ) async {
    if (!await (internetConnection.hasInternectConnection)) {
      return left(Failure("No network conection"));
    }
    try {
      final res =
          await authRemoteDataSource.loginUpWithEmailPassword(email, password);
      return right(res);
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
    if (!await (internetConnection.hasInternectConnection)) {
      return left(Failure("No network conection"));
    }
    try {
      final res = await authRemoteDataSource.signUpWithEmailPassword(
        email,
        password,
        name,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
