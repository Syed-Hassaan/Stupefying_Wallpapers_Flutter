import 'package:flutter/material.dart';
import 'package:stupefying_wallpapers/Splash%20Screen/splash_screen.dart';
import 'package:stupefying_wallpapers/views/screens/category_screen.dart';
import 'package:stupefying_wallpapers/views/screens/home_screen.dart';
import 'package:stupefying_wallpapers/views/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stupefying Wallpapers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MySplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => MySplashScreen(),
        '/homeScreen': (context) => HomeScreen()
      },
    );
  }
}
