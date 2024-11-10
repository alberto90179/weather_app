import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  WeatherHomeState createState() => WeatherHomeState();
}

class WeatherHomeState extends State<WeatherHome> {
  final WeatherService weatherService = WeatherService();
  Weather? weather;
  String city = 'London'; // Ciudad predeterminada

  void getWeather() async {
    try {
      Weather fetchedWeather = await weatherService.fetchWeather(city);
      setState(() {
        weather = fetchedWeather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  // Método para mostrar el diálogo y cambiar la ciudad
  void _changeCity() {
    String newCity = city; // Almacena la ciudad actual

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change City'),
          content: TextField(
            onChanged: (value) {
              newCity = value; // Actualiza la nueva ciudad mientras se escribe
            },
            decoration: const InputDecoration(hintText: "Enter city name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  city = newCity; // Actualiza la ciudad
                  getWeather(); // Obtiene el clima para la nueva ciudad
                });
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: weather == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'City: $city',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Temperature: ${weather!.temperature}°C',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Description: ${weather!.description}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeCity, // Llama al método para cambiar la ciudad
        child: const Icon(Icons.location_city), // Cambia el ícono si lo deseas
      ),
    );
  }
}