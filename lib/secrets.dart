import 'package:flutter_dotenv/flutter_dotenv.dart';

final openWeatherApiKey = dotenv.get('WEATHER_API_KEY');

const Map<String, String> weatherSymbols = {
  "Clear": "☀️",
  "Clouds": "☁️",
  "Rain": "🌧️",
  "Snow": "❄️",
  "Thunderstorm": "⛈️",
  "Drizzle": "🌦️",
  "Mist": "🌫️",
};
