// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// WordPress Screen

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class WordPressScreen extends StatefulWidget {
  const WordPressScreen({super.key});

  @override
  State<WordPressScreen> createState() => _WordPressScreenState();
}

class _WordPressScreenState extends State<WordPressScreen> {

  List posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {

    final url = Uri.parse(
        "https://pinchofyum.com/wp-json/wp/v2/posts"
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          posts = jsonDecode(response.body);
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }

    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> openLink(String link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('No se pudo abrir $link');
    }
  }

  // Para limpiar etiquetas HTML del título
  String cleanTitle(String title) {
    return title.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recetas de Comida 🍽️")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {

          final post = posts[index];
          final title = cleanTitle(post['title']['rendered']);
          final link = post['link'];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(title),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => openLink(link),
            ),
          );
        },
      ),
    );
  }
}
