// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "auth_bloc.dart";

@immutable
sealed class AuthEvent {}

class UserSignup extends AuthEvent {
  final String email;
  final String password;
  final String name;
  UserSignup({
    required this.email,
    required this.password,
    required this.name,
  });
}

class UserLogin extends AuthEvent {
  final String email;
  final String password;
  UserLogin({
    required this.email,
    required this.password,
  });
}

class LoggedInUser extends AuthEvent {}
