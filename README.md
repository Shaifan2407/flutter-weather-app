# Weather App

A simple Flutter weather application that fetches forecast data from the OpenWeather API and shows:

- Current temperature
- Current weather condition
- Hourly forecast cards
- Additional weather details like humidity, wind speed, and pressure

## Features

- Built with Flutter and Material 3
- Uses OpenWeather 5-day / 3-hour forecast API
- Loads API key from a local `.env` file
- Refresh button to reload weather data
- Clean dark UI with forecast and info sections

## Tech Stack

- Flutter
- Dart
- `http`
- `intl`
- `flutter_dotenv`

## Project Structure

```text
lib/
  main.dart
  weather_screen.dart
  hourly_forecast_item.dart
  additional_info_item.dart
  secrets.dart
```

## Getting Started

### Prerequisites

- Flutter SDK installed
- A device, emulator, or simulator
- An OpenWeather API key

### Setup

1. Clone the project.
2. Install dependencies:

```bash
flutter pub get
```

3. Create a `.env` file in the project root:

```env
WEATHER_API_KEY=your_openweather_api_key
```

4. Run the app:

```bash
flutter run
```

## How It Works

The app loads the API key from `.env`, requests forecast data from OpenWeather, and displays:

- A main summary card for the latest weather
- A horizontal hourly forecast list
- Additional information cards for humidity, wind speed, and pressure

## Current Implementation Note

- The city is currently hardcoded in `lib/weather_screen.dart` as `Rajkot,in`.
- The app currently uses temperature values directly from the API response in Kelvin.

If you want, this can be improved next by adding:

- City search
- Celsius/Fahrenheit conversion
- Better error handling
- Dynamic location support

## Useful Commands

```bash
flutter pub get
flutter run
flutter analyze
flutter test
```

## API Reference

- OpenWeather API: https://openweathermap.org/forecast5

## License

This project is for learning and personal use.
