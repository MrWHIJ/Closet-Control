import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class WeatherService {
  static const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  // Future<Weather> getWeather(String cityName) async {
  //   final response =
  //       await http.get(Uri.parse('$BASE_URL?=$cityName&appid=$apiKey'));

  //   if (response.statusCode == 200) {
  //     return Weather.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load weather data');
  //   }
  // }
  Future<Weather> getWeather(String lat, String lon) async {
    log(lat);
    log(lon);
    final response = await http.get(
        Uri.parse('$baseURL?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    //log(position.latitude.toString());
    //log(position.longitude.toString());
    //log(city.toString());

    return city ?? '';
  }

  Future<List<double>> getCurrentCoordinates() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return [position.latitude, position.longitude];
  }
}
