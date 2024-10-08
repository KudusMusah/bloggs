import 'package:bloggs/src/features/auth/domain/entities/user_entity.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signin_usecase.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _userSignup;
  final UserSignInUsecase _userLogin;
  AuthBloc({
    required UserSignUpUsecase userSignup,
    required UserSignInUsecase userLogin,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<UserSignup>(_onUserLogin);
    on<UserLogin>(_onUsersLogin);
  }

  void _onUserLogin(UserSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userSignup(
      SignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (r) => emit(AuthSuccess(user: r)),
    );
  }

  void _onUsersLogin(UserLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (r) => emit(AuthSuccess(user: r)),
    );
  }
}
