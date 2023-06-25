import 'package:dartz/dartz.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/core/network/network_info.dart';
import 'package:gaz_test/data/data_sources/remote_datasources/remote_user_datasources.dart';
import 'package:gaz_test/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final RemoteUserDataSources remoteUserDataSources;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({required this.remoteUserDataSources, required this.networkInfo});

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    var isConnected = await networkInfo.isConnected;
    if(isConnected){
      try {
        await remoteUserDataSources.logIn(email, password);
        return const Right(null);
      } on ServerFailure catch (error) {
        return Left(error);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}