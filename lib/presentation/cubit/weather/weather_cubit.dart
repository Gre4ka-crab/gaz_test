import 'package:bloc/bloc.dart';
import 'package:gaz_test/domain/entities/weather_entity.dart';
import 'package:gaz_test/domain/use_cases/get_weather_use_case.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;
  WeatherCubit(this.getWeatherUseCase) : super(WeatherInitial());


  Future<void> getWeather({required String lat, required String lon, required Placemark geoInfo}) async {
    emit(WeatherLoading());

    var result = await getWeatherUseCase(ParamsGetWeather(lat: lat, lon: lon));
    result.fold(
          (error) => emit(WeatherError(message: error.toString())),
          (result) => emit(WeatherLoaded(result, geoInfo)),
    );
  }

  Future<void> init() async {
    Position position = await _determinePosition();

    List<Placemark> geoInforms = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    await getWeather(lat: position.latitude.toString(), lon: position.longitude.toString(), geoInfo: geoInforms.first);

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
