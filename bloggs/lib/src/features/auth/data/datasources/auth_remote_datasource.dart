// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloggs/src/core/error/exception.dart';
import 'package:bloggs/src/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Session? get getCurrentUserSession;

  Future<UserModel?> getLoggedInUser();

  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  );

  Future<UserModel> loginUpWithEmailPassword(
    String email,
    String password,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final SupabaseClient superbase;
  AuthRemoteDataSourceImpl({
    required this.superbase,
  });

  @override
  Session? get getCurrentUserSession => superbase.auth.currentSession;

  @override
  Future<UserModel?> getLoggedInUser() async {
    try {
      final userSession = getCurrentUserSession;
      if (userSession != null) {
        final user = await superbase.from('profiles').select().eq(
              "id",
              userSession.user.id,
            );

        return UserModel.fromJson(user.first).copyWith(
          email: userSession.user.email,
        );
      }
      return null;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final res = await superbase.auth
          .signInWithPassword(password: password, email: email);

      if (res.user == null) {
        throw ServerException("User is null");
      }

      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final res =
          await superbase.auth.signUp(password: password, email: email, data: {
        "name": name,
      });

      if (res.user == null) {
        throw ServerException("User is null");
      }

      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
