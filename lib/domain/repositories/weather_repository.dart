import 'package:dartz/dartz.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/domain/entities/weather_entity.dart';

abstract class WeatherRepository{
  Future<Either<Failure, List<WeatherEntity>>> getWeathers();
  Future<Either<Failure, void>> setWeathers(List<WeatherEntity> weathers);
}