import 'package:dartz/dartz.dart';
import 'package:gaz_test/core/error/failure.dart';

abstract class UserRepository{
  Future<Either<Failure, void>> signIn(String email, String password);
}