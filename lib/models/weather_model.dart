import 'package:xml/xml.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }

  factory Weather.fromXml(String xmlString) {
    final document = XmlDocument.parse(xmlString);

    final cityElement =
        document.findAllElements('city').isEmpty
            ? null
            : document.findAllElements('city').first;
    final temperatureElement =
        document.findAllElements('temperature').isEmpty
            ? null
            : document.findAllElements('temperature').first;
    final weatherElement =
        document.findAllElements('weather').isEmpty
            ? null
            : document.findAllElements('weather').first;

    final parsedCityName = cityElement?.getAttribute('name') ?? '';
    final temperatureValue = temperatureElement?.getAttribute('value') ?? '0';
    final parsedTemperature = double.tryParse(temperatureValue) ?? 0.0;
    final weatherValueRaw = weatherElement?.getAttribute('value') ?? '';
    final normalizedMainCondition = _normalizeCondition(weatherValueRaw);

    return Weather(
      cityName: parsedCityName,
      temperature: parsedTemperature,
      mainCondition: normalizedMainCondition,
    );
  }

  static String _normalizeCondition(String rawValue) {
    final value = rawValue.toLowerCase();
    if (value.contains('clear')) return 'Clear';
    if (value.contains('cloud')) return 'Clouds';
    if (value.contains('rain')) return 'Rain';
    if (value.contains('thunder')) return 'Thunderstorm';
    return rawValue;
  }
}
