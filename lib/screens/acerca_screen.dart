// Rozenny Pie Valentin / 2021-0685 / Tarea 6
// Pantalla "Acerca de" con información real y foto

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});


  final String nombre = "Rozenny Pie Valentin";
  final String matricula = "2021-0685";
  final String correo = "rozennyv@gmail.com";
  final String whatsapp = "+1 829-994-4427";
  final String linkedin = "https://www.linkedin.com/in/rozdevtech";
  final String github = "https://github.com/125FARAONA";


  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
        backgroundColor: const Color(0xFFFACF5A),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 70,
              backgroundImage: const AssetImage("assets/profile/foto.png"),
            ),
            const SizedBox(height: 20),


            Text(
              nombre,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              matricula,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),


            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _launchURL("mailto:$correo"),
                  icon: const Icon(Icons.email),
                  label: const Text("Correo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFACF5A),
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () =>
                      _launchURL("https://wa.me/18299944427"),
                  icon: const Icon(Icons.call),
                  label: const Text("WhatsApp"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => _launchURL(linkedin),
                  icon: const Icon(Icons.business),
                  label: const Text("LinkedIn"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A66C2),
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => _launchURL(github),
                  icon: const Icon(Icons.code),
                  label: const Text("GitHub"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
