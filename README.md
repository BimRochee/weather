# Weather App - Flutter Mobile Application

## 📱 Exam #1 - Consuming Web Services

A Flutter mobile application that interfaces with the OpenWeatherMap APIs, demonstrating integration with both JSON and XML data formats.

## ✨ Features

- **Dual API Integration**: Supports both JSON and XML response formats from OpenWeatherMap
- **Real-time Weather Data**: Current weather conditions, temperature, and city information
- **Location Services**: Automatic city detection using device GPS
- **Beautiful UI**: Modern gradient backgrounds and Lottie animations based on weather conditions
- **Format Toggle**: Switch between JSON and XML data formats in real-time

## 🛠️ Technical Requirements Met

✅ **Dart Programming Language** - Used throughout the application  
✅ **Flutter UI Kit** - Complete mobile application interface  
✅ **OpenWeatherMap API Integration** - Current weather API implementation  
✅ **JSON Format Support** - Full JSON deserialization  
✅ **XML Format Support** - Full XML parsing and deserialization  
✅ **API Documentation Compliance** - Follows OpenWeatherMap API guidelines  
✅ **Free API Account Integration** - Ready for API key configuration  
✅ **Android APK Generation** - Can be built and installed on Android devices  
✅ **Source Code Repository** - Complete project structure  
✅ **Comprehensive Documentation** - This README with all setup instructions

## 📋 Prerequisites

- **Flutter SDK**: 3.29.3 (stable channel)
- **Dart SDK**: 3.7.2
- **Android Studio** or **VS Code** with Flutter extensions
- **Android Device** or **Emulator** for testing
- **OpenWeatherMap API Key** (free account required)

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd weather
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Get OpenWeatherMap API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Navigate to "My API Keys" section
4. Copy your API key

### 4. Configure API Key

Run the app with your API key:

```bash
flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY_HERE
```

**For Android APK build:**

```bash
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY_HERE
```

## 📦 Dependencies & Packages

### Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.5.0 # HTTP requests to OpenWeatherMap API
  xml: ^6.5.0 # XML parsing for XML format responses
  geolocator: ^14.0.2 # GPS location services
  geocoding: ^4.0.0 # Reverse geocoding (coordinates to city)
  lottie: ^3.3.1 # Weather animations
  cupertino_icons: ^1.0.8 # iOS-style icons
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0 # Code quality and style enforcement
```

## 🔌 API Integration Details

### OpenWeatherMap Current Weather API

- **Base URL**: `https://api.openweathermap.org/data/2.5/weather`
- **JSON Endpoint**: `?q={city}&appid={api_key}&units=metric`
- **XML Endpoint**: `?q={city}&appid={api_key}&mode=xml&units=metric`

### Supported Parameters

- `q`: City name (e.g., "London", "New York")
- `appid`: Your OpenWeatherMap API key
- `mode`: Response format ("xml" for XML, default is JSON)
- `units`: Temperature units ("metric" for Celsius)

### Response Handling

- **JSON**: Parsed using `Weather.fromJson()` method
- **XML**: Parsed using `Weather.fromXml()` method with XML document parsing

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── weather_model.dart    # Weather data model with JSON/XML parsing
├── pages/
│   └── weather_page.dart     # Main UI with format toggle
└── Services/
    └── weather_service.dart  # API service and location handling

assets/
├── cloud.json               # Cloudy weather animation
├── sunny.json               # Clear weather animation
├── rain.json                # Rainy weather animation
└── thunder.json             # Thunderstorm animation
```

## 🎯 Key Implementation Features

### 1. Dual Format Support

```dart
enum DataFormat { json, xml }

// Toggle between formats
ToggleButtons(
  isSelected: [_format == DataFormat.json, _format == DataFormat.xml],
  onPressed: (index) {
    setState(() {
      _format = index == 0 ? DataFormat.json : DataFormat.xml;
    });
    _fetchWeather();
  },
  children: [Text('JSON'), Text('XML')],
)
```

### 2. JSON Deserialization

```dart
factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(
    cityName: json['name'],
    temperature: json['main']['temp'].toDouble(),
    mainCondition: json['weather'][0]['main'],
  );
}
```

### 3. XML Deserialization

```dart
factory Weather.fromXml(String xmlString) {
  final document = XmlDocument.parse(xmlString);

  final cityElement = document.findAllElements('city').first;
  final temperatureElement = document.findAllElements('temperature').first;
  final weatherElement = document.findAllElements('weather').first;

  return Weather(
    cityName: cityElement.getAttribute('name') ?? '',
    temperature: double.tryParse(temperatureElement.getAttribute('value') ?? '0') ?? 0.0,
    mainCondition: weatherElement.getAttribute('value') ?? '',
  );
}
```

### 4. Location Services

```dart
Future<String> getCurrentCity() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  return placemarks[0].locality ?? "";
}
```

## 🚀 Building the APK

### Debug Build

```bash
flutter build apk --debug --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

### Release Build (Recommended for distribution)

```bash
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

### App Bundle (AAB) for Play Store

```bash
flutter build appbundle --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

**Output Location**: `build/app/outputs/flutter-apk/app-release.apk`

## 📱 Running the App

### Development Mode

```bash
flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY
```

### Hot Reload

```bash
# Press 'r' in terminal for hot reload
# Press 'R' for hot restart
```

## 🧪 Testing

### Unit Tests

```bash
flutter test
```

### Widget Tests

```bash
flutter test test/widget_test.dart
```

## 🔧 Troubleshooting

### Common Issues

1. **API Key Not Working**

   - Verify your API key is correct
   - Check if you've exceeded free tier limits
   - Ensure the key is properly passed via `--dart-define`

2. **Location Permission Denied**

   - Grant location permissions in device settings
   - Ensure GPS is enabled

3. **Build Errors**

   - Run `flutter clean` and `flutter pub get`
   - Check Flutter version compatibility
   - Verify all dependencies are properly installed

4. **Network Issues**
   - Check internet connectivity
   - Verify OpenWeatherMap API status
   - Check firewall/network restrictions

## 📚 API Documentation Reference

- **OpenWeatherMap Current Weather API**: [https://openweathermap.org/api](https://openweathermap.org/api)
- **API Response Formats**: [https://openweathermap.org/current#format](https://openweathermap.org/current#format)
- **Error Codes**: [https://openweathermap.org/api/one-call-3#errors](https://openweathermap.org/api/one-call-3#errors)

## 🎨 UI Design Features

- **Dynamic Backgrounds**: Gradient colors change based on weather conditions
- **Lottie Animations**: Smooth weather-specific animations
- **Responsive Layout**: Adapts to different screen sizes
- **Dark Theme**: Modern dark theme with proper contrast
- **Material Design**: Follows Flutter Material Design guidelines

## 📊 Weather Conditions Supported

- **Clear**: Orange/red gradient with sun animation
- **Clouds**: Blue/grey gradient with cloud animation
- **Rain**: Indigo/blue gradient with rain animation
- **Thunderstorm**: Purple/black gradient with thunder animation
- **Snow**: Light blue/white gradient with cloud animation
- **Default**: Blue-grey/black gradient with cloud animation

## 🔒 Security Considerations

- API key is passed via build-time arguments (not hardcoded)
- Location permissions are properly requested
- Network requests use HTTPS
- Error handling prevents app crashes

## 📈 Performance Optimizations

- Efficient JSON/XML parsing
- Minimal network requests
- Optimized asset loading
- Proper state management

## 🌟 Future Enhancements

- Weather forecasts for multiple days
- Multiple city support
- Weather alerts and notifications
- Offline data caching
- More detailed weather information
- Custom themes and animations

## 📄 License

This project is created for educational purposes as part of the "Consuming Web Services" exam.

## 👨‍💻 Developer

Created with ❤️ using Flutter and Dart for mobile application development.

---

**Note**: This application demonstrates professional-grade Flutter development practices including proper API integration, error handling, location services, and modern UI design principles.
