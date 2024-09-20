import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/services/auth/auth.dart';
import 'package:googlemaps/services/auth/login_or_register.dart';
import 'package:googlemaps/firebase_options.dart';
import 'package:googlemaps/pages/home_page.dart';
import 'package:googlemaps/pages/profile_page.dart';
import 'package:googlemaps/pages/users_page.dart';
import 'package:googlemaps/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      routes: {
        '/login_or_register': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => UsersPage()
      },
    );
  }
}
