import 'package:gaz_test/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    super.dt,
    super.main,
    super.weather,
    super.clouds,
    super.wind,
    super.visibility,
    super.pop,
    super.sys,
    super.dtTxt,
  });

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'main': main.toString(),
    'weather': weather.toString(),
    'clouds': clouds.toString(),
    'wind': wind.toString(),
    'visibility': visibility.toString(),
    'pop': pop.toString(),
    'sys': sys.toString(),
    'dtTxt': dtTxt.toString(),
  };

  @override
  String toString() {
    return toJson().toString();
  }
}