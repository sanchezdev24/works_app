
import 'package:fpdart/fpdart.dart';
import 'package:works_app/core/error/failures.dart';

typedef ResultFuture<T> = TaskEither<Failure, T>;
typedef ResultVoid = TaskEither<Failure, Unit>;