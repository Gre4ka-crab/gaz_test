import 'package:dartz/dartz.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/core/network/network_info.dart';
import 'package:gaz_test/data/data_sources/remote_datasources/remote_weather_datasources.dart';
import 'package:gaz_test/domain/entities/weather_entity.dart';
import 'package:gaz_test/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final NetworkInfo networkInfo;
  final RemoteWeatherDataSources remoteWeatherDataSources;

  WeatherRepositoryImpl({required this.networkInfo, required this.remoteWeatherDataSources});

  @override
  Future<Either<Failure, List<WeatherEntity>>> getWeathers(String lat, String lon) async {
    var isConnected = await networkInfo.isConnected;
    if(isConnected){
      try {
        var response =  await remoteWeatherDataSources.getData(lat, lon);
        return Right(response);
      } on ServerFailure catch (error) {
        return Left(error);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setWeathersFromCache(List<WeatherEntity> weathers) {
    // TODO: implement setWeathers
    throw UnimplementedError();
  }

}