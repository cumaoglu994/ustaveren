import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Giris extends StatefulWidget {
  const Giris({super.key});

  @override
  State<Giris> createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  String mesaj = "Yükleniyor...";

  @override
  void initState() {
    super.initState();
    veriGetir();
  }

  void veriGetir() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ustabul')
          .doc('ustabul')
          .get();

      if (snapshot.exists) {
        var data = snapshot.data()!;
        setState(() {
          mesaj = "Hoş geldin ${data['ad']} (${data['yas']})";
        });
      } else {
        setState(() {
          mesaj = "Kullanıcı bulunamadı.";
        });
      }
    } catch (e) {
      setState(() {
        mesaj = "Hata: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana Sayfa")),
      body: Center(
        child: Text(
          mesaj,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
