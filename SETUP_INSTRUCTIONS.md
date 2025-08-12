# Setup Instructions for Exam Evaluators

## 🎯 Quick Start Guide

This document provides step-by-step instructions for exam evaluators to run and test the Flutter Weather App on their machines.

## 📋 System Requirements

- **Operating System**: Windows 10/11, macOS, or Linux
- **Flutter SDK**: 3.29.3 or higher
- **Dart SDK**: 3.7.2 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Android Device** or **Emulator** for testing

## 🚀 Step-by-Step Setup

### Step 1: Verify Flutter Installation

```bash
flutter --version
flutter doctor
```

**Expected Output:**

```
Flutter 3.29.3 • channel stable
Framework • revision ea121f8859
Tools • Dart 3.7.2
```

### Step 2: Clone and Navigate to Project

```bash
git clone <repository-url>
cd weather
```

### Step 3: Install Dependencies

```bash
flutter pub get
```

**Expected Output:**

```
Running "flutter pub get" in weather...
Resolving dependencies...
Got dependencies!
```

### Step 4: Get OpenWeatherMap API Key

1. Visit: https://openweathermap.org/api
2. Click "Sign Up" and create a free account
3. After login, go to "My API Keys"
4. Copy your API key (it will look like: `abc123def456ghi789`)

### Step 5: Run the Application

```bash
flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY_HERE
```

**Example:**

```bash
flutter run --dart-define=OPENWEATHER_API_KEY=abc123def456ghi789
```

### Step 6: Test Both Data Formats

1. **JSON Format**: The app starts in JSON mode by default
2. **XML Format**: Click the "XML" toggle button in the top-right corner
3. **Verify**: Both formats should display the same weather data

## 📱 Testing on Android Device

### Option 1: Physical Device

1. Enable "Developer Options" on your Android device
2. Enable "USB Debugging"
3. Connect device via USB
4. Run: `flutter devices` to verify device detection
5. Run: `flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_KEY`

### Option 2: Android Emulator

1. Open Android Studio
2. Go to "AVD Manager" (Android Virtual Device Manager)
3. Create and start an emulator
4. Run: `flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_KEY`

## 🏗️ Building the APK

### Debug APK

```bash
flutter build apk --debug --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

### Release APK (Recommended for testing)

```bash
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

**APK Location**: `build/app/outputs/flutter-apk/app-release.apk`

## 🧪 Running Tests

### Unit Tests

```bash
flutter test
```

### Widget Tests

```bash
flutter test test/widget_test.dart
```

## 🔍 Verification Checklist

### ✅ API Integration

- [ ] App successfully connects to OpenWeatherMap API
- [ ] Weather data is displayed correctly
- [ ] Both JSON and XML formats work
- [ ] Location services function properly

### ✅ UI/UX

- [ ] Modern, responsive design
- [ ] Weather-based background gradients
- [ ] Lottie animations for weather conditions
- [ ] Format toggle between JSON/XML

### ✅ Code Quality

- [ ] Clean, well-structured code
- [ ] Proper error handling
- [ ] Location permission handling
- [ ] Efficient data parsing

### ✅ Build & Deployment

- [ ] APK builds successfully
- [ ] APK installs on Android device
- [ ] All dependencies resolved
- [ ] No build errors or warnings

## 🚨 Troubleshooting

### Common Issues and Solutions

#### 1. Flutter Version Mismatch

```bash
# Update Flutter to latest stable
flutter upgrade
flutter doctor
```

#### 2. Dependencies Issues

```bash
# Clean and reinstall
flutter clean
flutter pub get
```

#### 3. API Key Not Working

- Verify API key is correct
- Check if you've exceeded free tier limits
- Ensure proper `--dart-define` syntax

#### 4. Location Permission Issues

- Grant location permissions in device settings
- Ensure GPS is enabled
- Check app permissions in device settings

#### 5. Build Errors

```bash
# Clean build cache
flutter clean
flutter pub get
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

## 📊 Expected App Behavior

### Initial Launch

1. App requests location permission
2. Shows loading indicator while fetching weather
3. Displays current weather for detected city
4. Shows temperature, condition, and city name

### Format Toggle

1. Click "JSON" button (default)
2. Click "XML" button to switch format
3. Weather data refreshes with new format
4. Same information displayed in different format

### Weather Display

- **City Name**: Large text at top
- **Weather Animation**: Lottie animation based on condition
- **Temperature**: Large number in Celsius
- **Condition**: Weather description below temperature
- **Background**: Dynamic gradient based on weather

## 🔗 Additional Resources

- **Flutter Documentation**: https://flutter.dev/docs
- **OpenWeatherMap API**: https://openweathermap.org/api
- **Dart Language**: https://dart.dev/guides

## 📞 Support

If you encounter any issues during setup or testing, please:

1. Check the troubleshooting section above
2. Verify Flutter and Dart versions
3. Ensure all dependencies are properly installed
4. Check network connectivity for API calls

---

**Note**: This application demonstrates professional Flutter development practices and meets all exam requirements for consuming web services with both JSON and XML formats.
