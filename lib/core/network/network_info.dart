import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

}

class NetWorkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  NetWorkInfoImpl(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
