import 'package:dio/dio.dart';
import 'package:gaz_test/core/api/api.dart';
import 'package:gaz_test/core/error/failure.dart';

abstract class RemoteWeatherDataSources {
  Future<void> getData(String lat, String lon);
}

class RemoteWeatherDataSourcesImpl implements RemoteWeatherDataSources {
  final Api api;

  RemoteWeatherDataSourcesImpl({required this.api});

  @override
  Future<void> getData(String lat, String lon) async {
    try {
      await api.get(
        query: 'forecast',
        data: {
          'lat': lat,
          'appid': '87b4311bf4e04eac65daf0eade98dbba',
          'lang': 'ru'
        },
      );
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? '');
    }
  }
}
