import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class GenericException extends Failure {
  const GenericException(String message) : super(message);
}

class ServerException extends Failure {
  const ServerException(String message) : super(message);
}

class SocketFailure extends Failure {
  const SocketFailure(String message) : super(message);
}

class LocalDatabaseQueryFailure extends Failure {
  const LocalDatabaseQueryFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(String message) : super(message);
}
