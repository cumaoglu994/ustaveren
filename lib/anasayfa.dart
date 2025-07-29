import 'package:flutter/material.dart';

class  Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Burası Ana Sayfa (UstaBul Paneli)",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}