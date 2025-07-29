import 'package:flutter/material.dart';

class  Mesajlarim extends StatefulWidget {
  const   Mesajlarim({super.key});

  @override
  State<Mesajlarim> createState() => _MesajlarState();
}

class _MesajlarState extends State<Mesajlarim> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Burası Mesajlarım Sayfası",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}