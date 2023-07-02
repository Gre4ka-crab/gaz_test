import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/core/usecase/usecase.dart';
import 'package:gaz_test/domain/entities/weather_entity.dart';
import 'package:gaz_test/domain/repositories/weather_repository.dart';

class GetWeatherUseCase implements UseCase<void, ParamsGetWeather> {
  WeatherRepository weatherRepository;

  GetWeatherUseCase({required this.weatherRepository});

  @override
  Future<Either<Failure, List<WeatherEntity>>> call(ParamsGetWeather params) async {
    Either<Failure, List<WeatherEntity>> result = await weatherRepository.getWeathers(params.lat, params.lon);
    return result;
  }
}

class ParamsGetWeather implements Equatable{
  final String lat;
  final String lon;

  const ParamsGetWeather({required this.lat, required this.lon});

  @override
  List<Object?> get props => [lat, lon];

  @override
  bool? get stringify => null;

}