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

  /// Fetches the current weather using the devices longitude and latitude.
  ///
  /// Throws an [Exception] if the API could not be contacted.
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

  /// Fetches the city the device is currently in.
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

    return city ?? '';
  }

  /// Fetches the devices current coordinates.
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
