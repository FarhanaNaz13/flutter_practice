import 'package:data_connection_checker/data_connection_checker.dart';

abstract class ConnectionChecker {
  Future<bool> hasConnection();
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final DataConnectionChecker _dataConnectionChecker;

  ConnectionCheckerImpl(this._dataConnectionChecker);

  @override
  Future<bool> hasConnection() => _dataConnectionChecker.hasConnection;
}
