// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// Gender Screen

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _gender;
  bool _loading = false;

  Future<void> _predictGender(String name) async {
    setState(() => _loading = true);
    try {
      final url = Uri.parse('https://api.genderize.io/?name=$name');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _gender = data['gender'];
        });
      } else {
        setState(() => _gender = 'Error');
      }
    } catch (_) {
      setState(() => _gender = 'Error');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = _gender == 'male'
        ? Colors.blue.shade200
        : _gender == 'female'
        ? Colors.pink.shade200
        : Colors.grey.shade200;

    return Scaffold(
      appBar: AppBar(title: const Text('Gender Predictor')),
      body: Container(
        color: bgColor,
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
                  : () => _predictGender(_controller.text.trim()),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Predict Gender'),
            ),
            const SizedBox(height: 20),
            if (_gender != null)
              Text(
                'Gender: $_gender',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
