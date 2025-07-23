import 'package:flutter/material.dart';

class Profilim extends StatefulWidget {
  const Profilim({super.key});

  @override
  State<Profilim> createState() => _ProfilimState();
}

class _ProfilimState extends State<Profilim> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Burası Profilim Sayfası",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
