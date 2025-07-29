import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({super.key});

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  final adController = TextEditingController();
  final soyadController = TextEditingController();
  final meslekController = TextEditingController();
  final aciklamaController = TextEditingController();
  final konumController = TextEditingController();
  final yasController = TextEditingController();
  



  File? _selectedImage;
  String? _imageUrl;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }


Future<void> _konumuAlVeYaz() async {
  bool hizmetVarMi = await Geolocator.isLocationServiceEnabled();
  if (!hizmetVarMi) {
    print('Konum servisi kapalı');
    return;
  }

  LocationPermission izin = await Geolocator.checkPermission();
  if (izin == LocationPermission.denied) {
    izin = await Geolocator.requestPermission();
    if (izin == LocationPermission.denied) {
      print('Konum izni reddedildi');
      return;
    }
  }

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print("Koordinatlar: ${position.latitude}, ${position.longitude}");

  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  if (placemarks.isNotEmpty) {
    Placemark yer = placemarks[0];
    String konum = "${yer.locality}, ${yer.administrativeArea}";
    konumController.text = konum; // KONUM BURAYA OTOMATİK YAZILIR
    print("Konum alındı: $konum");
  }
}



  Future<String?> _uploadImage(File imageFile, String userId) async {
    try {
      setState(() {
        _isUploading = true;
      });
      
      final Reference storageRef = storage.ref().child('profile_images/$userId.jpg');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      print("Resim yükleme hatası: $e");
      return null;
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> profilBilgisiKaydet(String uid, Map<String, dynamic> bilgiler) async {
    try {
      print("Firestore'a kayıt başlıyor...");
      print("Kullanıcı ID: $uid");
      print("Kaydedilecek veri: ${bilgiler.toString()}");
      
      await firestore
          .collection('buyers')
          .doc(uid)
          .collection('profilBilgileri')
          .doc('bilgi')
          .set(bilgiler, SetOptions(merge: true));
      
      print("Firestore'a başarıyla kaydedildi.");
      
      // Kontrol için veriyi tekrar oku
      final doc = await firestore
          .collection('buyers')
          .doc(uid)
          .collection('profilBilgileri')
          .doc('bilgi')
          .get();
      
      print("Okunan veri: ${doc.data()}");
    } catch (e) {
      print("Firestore yazım hatası: $e");
      if (e is FirebaseException) {
        print("Hata kodu: ${e.code}");
        print("Hata mesajı: ${e.message}");
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanici Bilgileri"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : (_imageUrl != null
                          ? NetworkImage(_imageUrl!)
                          : const AssetImage('assets/default_profile.png') as ImageProvider),
                  child: _selectedImage == null && _imageUrl == null
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                      : null,
                ),
              ),
            ),
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
    prefixIcon: Icon(Icons.location_on, color: Color.fromARGB(255, 2, 9, 16)),
    suffixIcon: IconButton(
      icon: Icon(Icons.my_location),
      onPressed: _konumuAlVeYaz, // Add this to call the function when pressed
    ),
  ),
  readOnly: true, // Make the field read-only since location will be set automatically
  onTap: _konumuAlVeYaz, // Also call the function when the field is tapped
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
            ),
            const SizedBox(height: 6),
           
            const SizedBox(height: 20),
            _isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Hata"),
                              content: const Text("Kayıt yapabilmek için giriş yapmalısınız."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Tamam"),
                                )
                              ],
                            ),
                          );
                          return;
                        }

                        String uid = user.uid;
                        
                        if (_selectedImage != null) {
                          _imageUrl = await _uploadImage(_selectedImage!, uid);
                          if (_imageUrl != null) {
                            print("Resim başarıyla yüklendi: $_imageUrl");
                          }
                        }

                      

                        Map<String, dynamic> bilgiler = {
                          'ad': adController.text,
                          'soyad': soyadController.text,
                          'meslek': meslekController.text,
                          'aciklama': aciklamaController.text,
                          'konum': konumController.text,
                          'yas': yasController.text,
                         
                          'kayitTarihi': FieldValue.serverTimestamp(),
                          'profilResmi': _imageUrl,
                        };

                        await profilBilgisiKaydet(uid, bilgiler);

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Başarılı"),
                            content: const Text("Profil bilgileri başarıyla kaydedildi."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Tamam"),
                              )
                            ],
                          ),
                        );
                      } catch (e) {
                        print("Hata oluştu: $e");
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Hata"),
                            content: Text("Bir hata oluştu: ${e.toString()}"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Tamam"),
                              )
                            ],
                          ),
                        );
                      }
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