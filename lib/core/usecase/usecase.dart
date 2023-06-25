import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gaz_test/core/error/failure.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}


abstract class StreamUseCase<Type> {
  Stream<Either<Failure, Type>> call();
}