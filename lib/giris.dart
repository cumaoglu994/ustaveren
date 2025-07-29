import 'package:flutter/material.dart';

void main() {
  runApp(const giris());
}

class giris extends StatelessWidget {
  const giris({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ana Sayfa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Giris(),
      debugShowCheckedModeBanner: false, // burda sağ ust küşede kırmızı andı kaldırılmasını ağlar
    
    );
  }
}

class Giris extends StatelessWidget {
  const Giris({super.key});

  @override
  Widget build(BuildContext context) {
 final adController = TextEditingController();
 final soyadController = TextEditingController();
 final meslekController = TextEditingController();
 final aciklamaController = TextEditingController();
 final konumController = TextEditingController();
 final yasController = TextEditingController();
 final sehirController = TextEditingController();


  return Scaffold(
 appBar: AppBar(title: const Text("Kullanici Bilgileri")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: adController,
              decoration: const InputDecoration(
                labelText: "Ad",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: soyadController,
              decoration: const InputDecoration(
                labelText: "Soyad",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: meslekController,
              decoration: const InputDecoration(
                labelText: "Meslek",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: aciklamaController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Açıklama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: konumController,
              decoration: const InputDecoration(
                labelText: "Konum",
                border: OutlineInputBorder(),
              ),
            ),
             const SizedBox(height: 12),
            TextField(
              controller: yasController,
              decoration: const InputDecoration(
                labelText: "yas",
                border: OutlineInputBorder(),
              ),
            ), const SizedBox(height: 12),
            TextField(
              controller: sehirController,
              decoration: const InputDecoration(
                labelText: "sehir",
                border: OutlineInputBorder(),
              ),
             
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String bilgi = '''
Ad: ${adController.text}
Soyad: ${soyadController.text}
Meslek: ${meslekController.text}
Açiklama: ${aciklamaController.text}
Konum: ${konumController.text}
yas:${yasController.text}
sehir:${sehirController.text}
''';

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Girilen Bilgiler"),
                    content: Text(bilgi),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Kapat"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
