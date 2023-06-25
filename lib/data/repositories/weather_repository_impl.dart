import 'package:dartz/dartz.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/domain/entities/weather_entity.dart';
import 'package:gaz_test/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  @override
  Future<Either<Failure, List<WeatherEntity>>> getWeathers() {
    // TODO: implement getWeathers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> setWeathers(List<WeatherEntity> weathers) {
    // TODO: implement setWeathers
    throw UnimplementedError();
  }

}