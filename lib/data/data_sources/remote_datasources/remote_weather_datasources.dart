import 'package:dio/dio.dart';
import 'package:gaz_test/core/api/api.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/data/models/weather_model.dart';

abstract class RemoteWeatherDataSources {
  Future<List<WeatherModel>> getData(String lat, String lon);
}

class RemoteWeatherDataSourcesImpl implements RemoteWeatherDataSources {
  final Api api;

  RemoteWeatherDataSourcesImpl({required this.api});

  @override
  Future<List<WeatherModel>> getData(String lat, String lon) async {
    try {
      var response = await api.get(
        query: 'forecast',
        data: {
          'lat': lat,
          'lon': lon,
          'appid': '87b4311bf4e04eac65daf0eade98dbba',
          'lang': 'ru'
        },
      );

      return (response.data as Map)['list'].map<WeatherModel>((e) => WeatherModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? '');
    }
  }
}
