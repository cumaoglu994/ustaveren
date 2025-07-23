import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_6/giris.dart';
import 'main.dart';  // main.dart dosyasını import ettik

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main1());
}

class Main1 extends StatelessWidget {
  const Main1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giriş Ekranı',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GirisEkrania(),
    );
  }
}

class GirisEkrania extends StatefulWidget {
  const GirisEkrania({super.key});

  @override
  State<GirisEkrania> createState() => _GirisEkraniaState();
}

class _GirisEkraniaState extends State<GirisEkrania> {
  final emailController = TextEditingController();
  final sifreController = TextEditingController();

  void _girisYap() async {
    String email = emailController.text.trim();
    String sifre = sifreController.text.trim();

    if (email.isEmpty || sifre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen e-posta ve şifreyi doldurun!")),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: sifre,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Giriş başarılı!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const giris()),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://st.depositphotos.com/2390789/55852/i/450/depositphotos_558523060-stock-photo-ulu-cami-diyarbakir-grand-mosque.jpg'),
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
                  'Giriş Sayfası',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 66, 40),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 81, 219, 221), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 30, 173, 101), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.mail),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 81, 219, 221), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 30, 173, 101), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _girisYap,
                      child: const Text('Giriş Yap'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 131, 227, 105),
                      ),
                    ),
                    const SizedBox(width: 100),
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Google ile kayıt")),
                        );
                      },
                      icon: const Icon(Icons.g_mobiledata),
                      iconSize: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Facebook ile kayıt")),
                        );
                      },
                      icon: const Icon(Icons.facebook),
                      iconSize: 50,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Twitter ile kayıt")),
                        );
                      },
                      icon: const Icon(Icons.alternate_email),
                      iconSize: 50,
                      color: Colors.lightBlue,
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hesabınız yoksa kayıt yapınız.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(179, 255, 255, 255)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Burada kayıt sayfasına yönlendirme yapılacak:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GirisEkrani()),
                          // main.dart içindeki kayıt ekranı widget'ı Main olarak varsayıldı
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        side: const BorderSide(
                            color: Color.fromARGB(255, 4, 52, 49), width: 2),
                      ),
                      child: const Text(
                        'Kayıt Yap',
                        style:
                            TextStyle(color: Color.fromARGB(255, 5, 216, 110)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  '© 2025 Şirket Adı Tüm hakları saklıdır.',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(179, 255, 255, 255)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
