part of "app_user_cubit.dart";

@immutable
sealed class UserState {}

class UserInitial extends UserState {}

class UserLoggedIn extends UserState {
  final User user;
  UserLoggedIn({
    required this.user,
  });
}
