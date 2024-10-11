import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class InternetConnection {
  Future<bool> get hasInternectConnection;
}

class InternetConnectionImpl implements InternetConnection {
  @override
  Future<bool> get hasInternectConnection =>
      InternetConnectionChecker().hasConnection;
}
