abstract class Failure implements Exception {
  final String code;
  final String? message;
  final Map<String, dynamic>? meta;
  const Failure(this.code, {this.message, this.meta});
}

class ServerFailure extends Failure {
  const ServerFailure(super.code, {super.message, super.meta});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.code, {super.message, super.meta});
}

class CacheFailure extends Failure {
  const CacheFailure(super.code, {super.message, super.meta});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.code, {super.message, super.meta});
}
