import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetConnectionChecker {
  Future<bool> get hasInternectConnection;
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  @override
  Future<bool> get hasInternectConnection async =>
      await InternetConnection().hasInternetAccess;
}
