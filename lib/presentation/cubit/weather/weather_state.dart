part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherEntity> weatherList;
  Placemark geoInfo;

  WeatherLoaded(this.weatherList, this.geoInfo);
}

class WeatherError extends WeatherState {
  final String? message;

  WeatherError({this.message});
}
