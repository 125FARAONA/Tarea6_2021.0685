import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {

  final TextEditingController _controller = TextEditingController();
  List<dynamic> _universities = [];
  bool _loading = false;
  String? _message;

  Future<void> _fetchUniversities() async {
    final country = _controller.text.trim();

    if (country.isEmpty) {
      setState(() {
        _message = "Enter country name in English.";
      });
      return;
    }

    setState(() {
      _loading = true;
      _message = null;
      _universities = [];
    });

    try {
      final encodedCountry = Uri.encodeComponent(country);
      final url = Uri.parse(
          "https://adamix.net/proxy.php?country=$encodedCountry");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty) {
          setState(() {
            _universities = data;
          });
        } else {
          setState(() {
            _message = "No universities found.";
          });
        }
      } else {
        setState(() {
          _message = "Failed to load data.";
        });
      }
    } catch (e) {
      setState(() {
        _message = "Error: $e";
      });
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Universities")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Country name (English)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading ? null : _fetchUniversities,
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Search"),
            ),
            const SizedBox(height: 20),

            if (_message != null)
              Text(_message!, style: const TextStyle(color: Colors.red)),

            if (_universities.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _universities.length,
                  itemBuilder: (context, index) {
                    final uni = _universities[index];
                    return Card(
                      child: ListTile(
                        title: Text(uni["name"] ?? ""),
                        subtitle: Text((uni["domains"] as List).join(", ")),
                        trailing: IconButton(
                          icon: const Icon(Icons.open_in_new),
                          onPressed: () =>
                              _openUrl((uni["web_pages"] as List).first),
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
