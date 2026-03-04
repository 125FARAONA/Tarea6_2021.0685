// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// Pokemon Screen

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _pokemon;
  bool _loading = false;

  Future<void> _getPokemon(String name) async {
    setState(() => _loading = true);
    try {
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _pokemon = json.decode(response.body);
        });
      } else {
        setState(() => _pokemon = null);
      }
    } catch (_) {
      setState(() => _pokemon = null);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Pokemon name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () => _getPokemon(_controller.text.trim().toLowerCase()),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Get Pokemon'),
            ),
            const SizedBox(height: 20),
            if (_pokemon != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        _pokemon!['sprites']['front_default'] ?? '',
                        height: 150,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Name: ${_pokemon!['name']}',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text('Base Exp: ${_pokemon!['base_experience']}'),
                      const SizedBox(height: 10),
                      Text(
                        'Abilities: ${(_pokemon!['abilities'] as List).map((e) => e['ability']['name']).join(', ')}',
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
