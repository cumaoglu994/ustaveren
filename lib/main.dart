import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart' show LoginScreen;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UstaVeren',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 185, 235, 252),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 185, 235, 252),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const GirisEkrani(),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final adController = TextEditingController();
  final soyadController = TextEditingController();
  final emailController = TextEditingController();
  final sifreController = TextEditingController();
  final sifreTekrarController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> kullaniciKaydet(String kullaniciAdi, String email, String uid) async {
    await firestore.collection('buyers').doc(uid).set({
      'kullaniciAdi': kullaniciAdi,
      'buyerId': uid,
      'address': '',
      'hizmetTuru': 'veren',
      'phone': '',
      
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  void _kayitOl() async {
    if (sifreController.text != sifreTekrarController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Şifreler uyuşmuyor!")),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: sifreController.text.trim(),
      );

      String uid = userCredential.user!.uid;
      String kullaniciAdi = soyadController.text.trim();
      String email = emailController.text.trim();

      await kullaniciKaydet(kullaniciAdi, email, uid);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt başarılı: $email")),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://idsb.tmgrup.com.tr/ly/uploads/images/2024/07/28/338803.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Kayıt Sayfası',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 66, 40),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: soyadController,
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 3, 240, 244),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 30, 173, 101),
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 135, 205, 115),
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta veya telefon',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 81, 219, 221), width: 5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 30, 173, 101), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 135, 205, 115),
                    filled: true,
                    prefixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre gir',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 81, 219, 221), width: 5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 30, 173, 101), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 135, 205, 115),
                    filled: true,
                    prefixIcon: Icon(Icons.visibility, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: sifreTekrarController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre tekrar gir',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 81, 219, 221), width: 5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 30, 173, 101), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Color.fromARGB(255, 135, 205, 115),
                    filled: true,
                    prefixIcon: Icon(Icons.visibility, color: Color.fromARGB(255, 2, 9, 16)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _kayitOl();
                      },
                      child: const Text('Kayıt Ol'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 131, 227, 105),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Şifremi unuttum tıklandı')),
                        );
                      },
                      child: const Text(
                        'Şifremi unuttum?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 143, 237, 2),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.g_mobiledata),
                      iconSize: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      iconSize: 50,
                      color: Color.fromARGB(255, 10, 196, 118),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.alternate_email),
                      iconSize: 50,
                      color: Color.fromARGB(255, 13, 187, 19),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hesabınız varsa giriş yapınız.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(179, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        side: const BorderSide(
                          color: Color.fromARGB(255, 4, 52, 49),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(color: Color.fromARGB(255, 5, 216, 110)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}