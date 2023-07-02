
class WeatherEntity {
  final DateTime? dt;
  final WeatherMainEntity? main;
  final List<WeatherDetailEntity>? weather;
  final CloudsEntity? clouds;
  final WindEntity? wind;
  final int? visibility;
  final double? pop;
  final SysEntity? sys;
  final String? dtTxt;

  const WeatherEntity({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });
}

class WeatherMainEntity {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  const WeatherMainEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });
}

class WeatherDetailEntity {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherDetailEntity({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
}

class CloudsEntity {
  final int? all;

  const CloudsEntity({this.all});
}

class WindEntity {
  final double? speed;
  final int? deg;
  final double? gust;

  const WindEntity({
    this.speed,
    this.deg,
    this.gust,
  });
}

class SysEntity {
  final String? pod;

  const SysEntity({this.pod});

}
