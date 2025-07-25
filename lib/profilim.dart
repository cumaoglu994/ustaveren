import 'package:flutter/material.dart';
import 'AnaProfil.dart';

class Profilim extends StatefulWidget {
  const Profilim({super.key});

  @override
  State<Profilim> createState() => _ProfilimState();
}

class _ProfilimState extends State<Profilim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // ← return eksikti, eklendi
      body: Column(
        children: [
          const SizedBox(height: 50), // Yukarıdan boşluk
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 136, 218, 219),
                foregroundColor: const Color.fromARGB(255, 16, 14, 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 5,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilSayfasi()),
                );
              },
              child: const Center(child: Text("Profilim")),
            ),
          ),
        ],
      ),
    );
  }
}
