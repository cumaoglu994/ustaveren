import 'package:flutter/material.dart';

class ProfilSayfasi extends StatelessWidget {
  const ProfilSayfasi({super.key});

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
 appBar: AppBar(title: const Text("Kullanici Bilgileri"),
leading: IconButton(    icon: const Icon(Icons.arrow_back), // sayfadan geri gitme 
   onPressed: () {   
       Navigator.pop(context);   
        }, 
         ),

 ),
 
      body: Container(
       decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://cdn3.hipicon.com/images/bd/products/2024/11/05/hgo-atelier--u2-aydnlatma--173080476655348.jpg&w=990&h=990'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: adController,
              decoration: InputDecoration(
                    labelText: ' Adı',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 24, 148, 209),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 22, 142, 186),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: soyadController,
             decoration: InputDecoration(
                    labelText: 'Soyadı',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 26, 151, 234),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 12, 148, 197),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: meslekController,
              decoration: InputDecoration(
                    labelText: 'Meslek',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 26, 151, 234),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 12, 148, 197),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: aciklamaController,
              maxLines: 3,
              decoration: InputDecoration(
                    labelText: 'Açıklama',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 26, 151, 234),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 12, 148, 197),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: konumController,
              decoration: InputDecoration(
                    labelText: 'Konum',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 26, 151, 234),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 12, 148, 197),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
            ),
             const SizedBox(height: 6),
            TextField(
              controller: yasController,
              decoration: InputDecoration(
                    labelText: 'Yaş',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 26, 151, 234),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 12, 148, 197),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
            ), const SizedBox(height: 6),
            TextField(
              controller: sehirController,
              decoration: InputDecoration(
                    labelText: 'Şehir',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 26, 151, 234),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 12, 148, 197),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
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
                        child: const Text("çıkış"),
                      )
                    ],
                  ),
                );
              },
              child: const Text(
    "Kaydet",
    style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



