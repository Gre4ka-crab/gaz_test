import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/core/usecase/usecase.dart';
import 'package:gaz_test/domain/repositories/user_repository.dart';

class LogIn implements UseCase<void, ParamsLogIn> {
  UserRepository userRepository;

  LogIn({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(ParamsLogIn params) async {
    Either<Failure, void> result = await userRepository.signIn(params.email, params.password);

    result.fold((error) => error, (result) => null);

    return result;
  }
}

class ParamsLogIn implements Equatable{
  final String email;
  final String password;

  const ParamsLogIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  bool? get stringify => null;

}