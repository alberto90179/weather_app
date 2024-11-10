// lib/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  final String apiKey = 'bed1996d36c9654935f0a6cfa7b619bd'; // Reemplaza con tu propia API key
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}