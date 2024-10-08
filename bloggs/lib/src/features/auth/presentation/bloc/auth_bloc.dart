import 'package:bloggs/src/core/usecase/usecase.dart';
import 'package:bloggs/src/core/common/entities/user_entity.dart';
import 'package:bloggs/src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signin_usecase.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _userSignup;
  final UserSignInUsecase _userLogin;
  final LoggedInUserUsecase _loggedInUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUpUsecase userSignup,
    required UserSignInUsecase userLogin,
    required LoggedInUserUsecase loggedInUser,
    required AppUserCubit appUserCubit,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        _loggedInUser = loggedInUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<UserSignup>(_onUserLogin);
    on<UserLogin>(_onUsersLogin);
    on<LoggedInUser>(_onLoggedInUser);
  }

  void _onUserLogin(UserSignup event, Emitter<AuthState> emit) async {
    final res = await _userSignup(
      SignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        _appUserCubit.updateUser(r);
        emit(AuthSuccess(user: r));
      },
    );
  }

  void _onUsersLogin(UserLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        _appUserCubit.updateUser(r);
        emit(AuthSuccess(user: r));
      },
    );
  }

  void _onLoggedInUser(LoggedInUser event, Emitter<AuthState> emit) async {
    final res = await _loggedInUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        _appUserCubit.updateUser(r);
        emit(AuthSuccess(user: r));
      },
    );
  }
}
