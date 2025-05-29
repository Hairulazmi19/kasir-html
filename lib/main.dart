import 'package:flutter/material.dart';
import 'kasir_page.dart';
import 'login_page.dart';
import 'admin_page.dart'; // ← tambahkan ini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Rumah Sakit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
        onLogin: (role) {
          // Navigasi akan dilakukan di LoginPage
        },
      ),
      routes: {
        '/petugas-kasir': (context) => const KasirPage(),
        '/admin': (context) => const AdminPage(), // ← tambahkan ini
      },
    );
  }
}
