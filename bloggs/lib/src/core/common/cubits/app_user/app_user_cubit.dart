import 'package:flutter/material.dart';
import 'package:bloggs/src/core/common/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<UserState> {
  AppUserCubit() : super(UserInitial());

  void updateUser(User? user) {
    if (user == null) {
      return emit(UserInitial());
    }

    emit(UserLoggedIn(user: user));
  }

  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);
  }
}
