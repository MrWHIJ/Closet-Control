import 'package:closet_control/core/add_clothing_page.dart';
import 'package:closet_control/features/home/weather_model.dart';
import 'package:closet_control/features/home/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:closet_control/config/environments.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;

  _fetchWeather() async {
    List<double> coordinates = await _weatherService.getCurrentCoordinates();
    String latitude = coordinates[0].toString();
    String longitude = coordinates[1].toString();

    try {
      final weather = await _weatherService.getWeather(latitude, longitude);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/lottie/weather/loading.json";

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lottie/weather/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lottie/weather/rain.json';
      case 'thunderstorm':
        return 'assets/lottie/weather/thunder.json';
      case 'clear':
        return 'assets/lottie/weather/sunny.json';
      default:
        return 'assets/lottie/weather/loading.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hallo,\n[Name]!',
                    style:
                        TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                  ),
                  // Text(_weather?.cityName ?? 'loading...'),
                  // Text('${_weather?.temperature.round()}°C'),
                  SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Lottie.asset(
                        getWeatherAnimation(_weather?.mainCondition)),
                  )
                ],
              ),
              // Text(context.watch<ClothesProvider>().allClothes.toString()),
              // TextButton(
              //     onPressed: () {
              //       context.read<ClothesProvider>().addClothing(
              //           id: 'dasisteineid', name: 'tshirt', brand: 'zara');
              //     },
              //     child: const Text('drück mich')),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddClothingPage()));
                },
                child: Container(
                  height: 150.h,
                  width: 500.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        // offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 180.h,
                          width: 180.w,
                          child: Lottie.asset(
                              'assets/lottie/other/add_new_clothes.json'),
                        ),
                        Text(
                          'Neues\nKleidungsstück\nhinzufügen',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 150.h,
                width: 500.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      // offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Neues\nOutfit\nhinzufügen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 200.h,
                        width: 200.w,
                        child: Lottie.asset(
                            'assets/lottie/other/add_new_outfit.json'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
