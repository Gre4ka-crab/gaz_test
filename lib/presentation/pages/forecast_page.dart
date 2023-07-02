import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaz_test/domain/entities/weather_entity.dart';
import 'package:gaz_test/presentation/cubit/weather/weather_cubit.dart';
import 'package:gaz_test/presentation/widgets/loading_widget.dart';
import 'package:gaz_test/units/pj_icons.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  WeatherEntity? currentWeather;
  List<WeatherEntity> weathers = [];
  final DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(listener: (BuildContext context, state) {
        if (state is WeatherError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? '')));
        }
      }, builder: (BuildContext context, state) {
        if (state is WeatherInitial) {
          context.read<WeatherCubit>().init();
        }

        if (state is WeatherLoaded) {
          for (var weather in state.weatherList) {
            if (weather.dt?.day == currentDate.day) {
              weathers.add(weather);
            }
            break;
          }
          currentWeather = weathers.first;

          return Container(
            padding: EdgeInsets.all(24.w),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color.fromRGBO(7, 0, 225, 1), Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white),
                      Text(
                        "${state.geoInfo.locality ?? ''}, ${state.geoInfo.country}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 180.w,
                        height: 180.w,
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(blurRadius: 60, spreadRadius: 2, color: Color.fromRGBO(189, 135, 255, 1))],
                        ),
                        child: Image.asset(PjIcons.bigCloudLightning, width: 150.w, height: 150.w),
                      )
                    ],
                  ),
                  _Text('${currentWeather?.main?.temp?.toInt()}º', fontSize: 64, fontWeight: FontWeight.w500),
                  _Text('${currentWeather?.weather?[0].description}'),
                  _Text('Макс.: ${currentWeather?.main?.tempMax?.toInt()}º Мин: ${currentWeather?.main?.tempMin?.toInt()}º'),
                  SizedBox(height: 5.h),
                  _WeatherSelectorList(
                    changeDate: currentWeather!.dt!,
                    weatherList: weathers,
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color.fromRGBO(7, 0, 225, 1), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: const LoadingWidget(),
        );
      }),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;

  const _Text(this.text, {Key? key, this.fontSize = 17, this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: fontWeight));
  }
}

class _WeatherSelectorList extends StatelessWidget {
  final List<WeatherEntity> weatherList;
  final DateTime changeDate;
  static const List<String> monthList = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ];

  const _WeatherSelectorList({Key? key, required this.weatherList, required this.changeDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _Text('Сегодня'),
                _Text('${changeDate.day} ${monthList[changeDate.month - 1]}'),
              ],
            ),
          ),
          Container(color: Colors.white, height: 1),
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
                children: List.generate(4, (index) {
              WeatherEntity e = weatherList[index];
              return _WeatherListItem(
                dateTime: e.dt,
                iconCode: e.weather?[0].icon,
                temp: e.main?.temp,
                isActive: e.dt == changeDate,
              );
            })),
          )
        ],
      ),
    );
  }
}

class _WeatherListItem extends StatelessWidget {
  final DateTime? dateTime;
  final String? iconCode;
  final double? temp;
  final bool isActive;

  const _WeatherListItem({Key? key, required this.dateTime, required this.iconCode, required this.temp, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> iconMap = {
      '03d': PjIcons.cloudLightning,
    };

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _Text("${dateTime?.hour}:00"),
          if (iconMap[iconCode] != null) ...[SvgPicture.asset(iconMap[iconCode]!)],
          _Text(temp.toString())
        ],
      ),
    );
  }
}
