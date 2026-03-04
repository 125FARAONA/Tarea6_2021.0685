// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// Weather Screen

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  String temperature = "";
  String description = "";
  bool loading = true;

  final String apiKey = "720bd1de3496387daf578d2754093467";

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {

    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Santo Domingo,DO&appid=$apiKey&units=metric&lang=es"
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          temperature = "${data['main']['temp']} °C";
          description = data['weather'][0]['description'];
          loading = false;
        });

      } else {
        setState(() {
          temperature = "No disponible";
          description = "Error ${response.statusCode}";
          loading = false;
        });
      }

    } catch (e) {
      setState(() {
        temperature = "Error de conexión";
        description = "Revisa internet";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clima en Santo Domingo")),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temperature,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
