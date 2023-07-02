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

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        dt: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
        main: WeatherMainModel.fromJson(json['main']),
        weather: (json['weather'] as List?)?.map((dynamic e) => WeatherDetailModel.fromJson(e)).toList(),
        clouds: CloudsModel.fromJson(json['clouds']),
        wind: WindModel.fromJson(json['wind']),
        visibility: json['visibility'] as int?,
        pop: json['pop']?.toDouble() as double?,
        sys: SysModel.fromJson(json['sys']),
        dtTxt: json['dt_txt'] as String?,
      );
}

class WeatherMainModel extends WeatherMainEntity {
  const WeatherMainModel({
    super.temp,
    super.feelsLike,
    super.tempMin,
    super.tempMax,
    super.pressure,
    super.seaLevel,
    super.grndLevel,
    super.humidity,
    super.tempKf,
  });

  factory WeatherMainModel.fromJson(Map<String, dynamic> json) => WeatherMainModel(
        temp: json['temp']?.toDouble() as double?,
        feelsLike: json['feels_like']?.toDouble() as double?,
        tempMin: json['temp_min']?.toDouble() as double?,
        tempMax: json['temp_max']?.toDouble() as double?,
        pressure: json['pressure'] as int?,
        seaLevel: json['sea_level'] as int?,
        grndLevel: json['grnd_level'] as int?,
        humidity: json['humidity'] as int?,
        tempKf: json['tempKf']?.toDouble() as double?,
      );
}

class WeatherDetailModel extends WeatherDetailEntity {
  const WeatherDetailModel({
    super.id,
    super.main,
    super.description,
    super.icon,
  });

  factory WeatherDetailModel.fromJson(Map<String, dynamic> json) => WeatherDetailModel(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );
}

class CloudsModel extends CloudsEntity {
  const CloudsModel({super.all});

  factory CloudsModel.fromJson(Map<String, dynamic> json) => CloudsModel(
        all: json['all'] as int?,
      );
}

class WindModel extends WindEntity {
  const WindModel({
    super.speed,
    super.deg,
    super.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
        speed: json['speed']?.toDouble() as double?,
        deg: json['deg'] as int?,
        gust: json['gust']?.toDouble() as double?,
      );
}

class SysModel extends SysEntity {
  const SysModel({super.pod});

  factory SysModel.fromJson(Map<String, dynamic> json) => SysModel(
        pod: json['pod'] as String?,
      );
}
