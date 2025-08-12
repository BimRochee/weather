# Build Verification Guide

## 🏗️ APK Build Process

### **Build Commands**

```bash
# Debug APK (for testing)
flutter build apk --debug --dart-define=OPENWEATHER_API_KEY=YOUR_KEY

# Release APK (for distribution)
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY

# App Bundle (for Play Store)
flutter build appbundle --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

### **Expected Output Location**

- **APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **AAB**: `build/app/outputs/bundle/release/app-release.aab`

## 🚨 Common Build Issues & Solutions

### **1. Network/Artifact Download Issues**

**Symptoms**: Build fails with "Could not download" errors
**Solution**:

```bash
# Clean and retry
flutter clean
flutter pub get
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_KEY
```

### **2. API Key Missing**

**Symptoms**: Build succeeds but app shows "Missing API key" message
**Solution**: Ensure you're using the `--dart-define` flag correctly

```bash
flutter build apk --release --dart-define=OPENWEATHER_API_KEY=YOUR_ACTUAL_KEY
```

### **3. Dependencies Issues**

**Symptoms**: Build fails with dependency resolution errors
**Solution**:

```bash
flutter clean
flutter pub cache repair
flutter pub get
```

### **4. Android SDK Issues**

**Symptoms**: Build fails with Android-related errors
**Solution**: Verify Android SDK installation

```bash
flutter doctor --android-licenses
flutter doctor
```

## ✅ **Build Success Indicators**

When the build succeeds, you should see:

```
✓ Built build/app/outputs/flutter-apk/app-release.apk (xx.x MB)
```

## 📱 **APK Installation Verification**

1. **Transfer APK** to Android device
2. **Enable "Install from unknown sources"** in device settings
3. **Install APK** by tapping the file
4. **Launch app** and verify it works
5. **Test both JSON and XML formats**

## 🔧 **Troubleshooting Commands**

```bash
# Check Flutter installation
flutter doctor

# Verify dependencies
flutter pub deps

# Clean build cache
flutter clean

# Update Flutter
flutter upgrade

# Check available devices
flutter devices
```

## 📊 **Build Performance Tips**

- Use `--release` flag for production builds
- Ensure stable internet connection during build
- Close unnecessary applications to free up memory
- Use SSD storage for faster build times

---

**Note**: The build process may take 2-5 minutes depending on your system and internet connection. Network issues are common and don't indicate problems with your code.
