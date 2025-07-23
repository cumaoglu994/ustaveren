import 'package:flutter/material.dart';

// Sayfalar importları
import 'anasayfa.dart';
import 'mesajlarim.dart';
import 'profilim.dart';
import 'hizmetlerim.dart';

void main() {
  runApp(const MyApp());
}

// Ana uygulama widget'ı (StatelessWidget olarak iyi seçilmiş)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MainPage(),
    );
  }
}

// MainPage StatefulWidget ile sayfalar arası geçiş ve durum yönetimi yapılıyor
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final PageController _pageController;

  // AppBar başlıkları
  static const List<String> _titles = [
    "UstaBul Paneli",
    "Hizmetlerim",
    "Mesajlarım",
    "Profilim",
  ];

  // Sayfalar listesi
  static final List<Widget> _pages = [
    Anasayfa(),
    Hizmetlerim(),
    Mesajlarim(),
    Profilim(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose(); // PageController mutlaka dispose edilmeli
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: _currentIndex == 3
            ? [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ayarlar butonuna tıklandı")),
                    );
                  },
                )
              ]
            : null,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF007AFF),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "Hizmetlerim",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Mesajlar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profilim",
          ),
        ],
      ),
    );
  }
}
