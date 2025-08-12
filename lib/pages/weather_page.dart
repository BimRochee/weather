import 'package:flutter/material.dart';
import 'package:weather/Services/weather_service.dart';
import 'package:weather/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

enum DataFormat { json, xml }

class _WeatherPageState extends State<WeatherPage> {
  // API key (provide via --dart-define=OPENWEATHER_API_KEY=YOUR_KEY)
  static const String _apiKey = String.fromEnvironment('OPENWEATHER_API_KEY');
  late final WeatherService _weatherService = WeatherService(_apiKey);
  Weather? _weather;
  DataFormat _format = DataFormat.json;

  // Fetch weather
  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather =
          _format == DataFormat.json
              ? await _weatherService.getWeather(cityName)
              : await _weatherService.getWeatherXml(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // Error handling - in production, use proper logging
      debugPrint("Error fetching weather: $e");
    }
  }

  // Weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/cloud.json';
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/cloud.json';
    }
  }

  // Background gradient based on weather
  List<Color> getBackgroundGradient(String? mainCondition) {
    if (mainCondition == null) return [Colors.blueGrey, Colors.black54];
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return [Colors.orangeAccent, Colors.deepOrange];
      case 'clouds':
        return [Colors.blueGrey, Colors.grey];
      case 'rain':
        return [Colors.indigo, Colors.blueGrey];
      case 'thunderstorm':
        return [Colors.deepPurple, Colors.black];
      case 'snow':
        return [Colors.lightBlueAccent, Colors.white];
      default:
        return [Colors.blueGrey, Colors.black54];
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = getBackgroundGradient(_weather?.mainCondition);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Weather'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ToggleButtons(
              isSelected: [
                _format == DataFormat.json,
                _format == DataFormat.xml,
              ],
              onPressed: (index) {
                setState(() {
                  _format = index == 0 ? DataFormat.json : DataFormat.xml;
                });
                _fetchWeather();
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Colors.white12,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('JSON'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('XML'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child:
              _apiKey.isEmpty
                  ? const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'Missing API key. Run with --dart-define=OPENWEATHER_API_KEY=YOUR_KEY',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                  : _weather == null
                  ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Fetching Weather...",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _weather!.cityName,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Lottie.asset(
                        getWeatherAnimation(_weather?.mainCondition),
                        height: 150,
                      ),
                      Text(
                        '${_weather!.temperature.round()}°C',
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _weather!.mainCondition,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
