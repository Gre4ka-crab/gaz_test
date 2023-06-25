import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/data/models/weather_model.dart';

abstract class LocalWeatherDataSources {
  Future<List<WeatherModel>> getData();
  Future<void> setData(List<WeatherModel> weathers);
}

class LocalWeatherDataSourcesImpl implements LocalWeatherDataSources {
  @override
  Future<List<WeatherModel>> getData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<void> setData(List<WeatherModel> weathers) {
    // TODO: implement setData
    throw UnimplementedError();
  }

  


}
