// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// Age Screen

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _controller = TextEditingController();
  int? _age;
  String? _category;
  bool _loading = false;

  Future<void> _predictAge(String name) async {
    setState(() => _loading = true);
    try {
      final url = Uri.parse('https://api.agify.io/?name=$name');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final int age = data['age'] ?? 0;
        setState(() {
          _age = age;
          if (age < 25) {
            _category = 'Joven';
          } else if (age < 60) {
            _category = 'Adulto';
          } else {
            _category = 'Anciano';
          }
        });
      } else {
        setState(() {
          _age = null;
          _category = 'Error';
        });
      }
    } catch (_) {
      setState(() {
        _age = null;
        _category = 'Error';
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Predictor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () => _predictAge(_controller.text.trim()),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Predict Age'),
            ),
            const SizedBox(height: 20),
            if (_age != null)
              Column(
                children: [
                  Text(
                    'Age: $_age',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Category: $_category',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
