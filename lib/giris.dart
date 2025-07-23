import 'package:flutter/material.dart';

void main() {
  runApp(const giris());
}

class giris extends StatelessWidget {
  const giris({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gegis giris',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Giris(),
    );
  }
}

class Giris extends StatelessWidget {
  const Giris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana Sayfa")),
      body: const Center(
        child: Text("Hoş geldin!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
