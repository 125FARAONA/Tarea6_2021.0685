// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// Home Screen - Optimized

import 'package:flutter/material.dart';
import 'package:tarea6_2021_0685/screens/acerca_screen.dart';
import 'package:tarea6_2021_0685/screens/universities_screen.dart';
import 'gender_screen.dart';
import 'age_screen.dart';
import 'pokemon_screen.dart';
import 'universities_screen.dart';
import 'weather_screen.dart';
import 'wordpress_screen.dart';
import 'acerca_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  final List<Widget> _screens = const [
    GenderScreen(),
    AgeScreen(),
    PokemonScreen(),
    UniversityScreen(),
    WeatherScreen(),
    WordPressScreen(),
    AcercaScreen(),
  ];


  final List<String> _titles = const [
    'Gender Predictor',
    'Age Predictor',
    'Pokemon Info',
    'Universities',
    'Weather RD',
    'WordPress News',
    'About Rozenny',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent, // bonito pero no azul
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (mounted) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Gender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Age',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokemon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'University',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'WordPress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
