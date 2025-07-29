import 'package:flutter/material.dart';
class Hizmetlerim extends StatefulWidget {
  const Hizmetlerim({super.key});

  @override
  State<Hizmetlerim> createState() => _HizmetlerimState();
}

class _HizmetlerimState extends State<Hizmetlerim> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Burası Hizmetlerim Sayfası",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}