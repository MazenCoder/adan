import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkConn {
  static Future<bool> get isConnected => DataConnectionChecker().hasConnection ?? false;

  //Future<bool> get isConnected => Future.value(true);
}

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;
  NetworkInfoImpl(this.connectionChecker);

  //@override
  //Future<bool> get isConnected => Future.value(true);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection ?? false;
}
