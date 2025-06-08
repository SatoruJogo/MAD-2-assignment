import 'package:flutter/material.dart';
import 'package:prepo/home_page.dart';
import 'package:prepo/splash_screen.dart';
import 'package:prepo/login_page.dart';
import 'package:prepo/cart_page.dart';
import 'package:prepo/build_meal_page.dart';
import 'package:prepo/profile_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prepo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/cart': (context) => CartPage(),
        '/buildMeal': (context) => BuildMealPage(),
        '/profile': (context) => ProfilePage(), 
      },
    );
  }
}

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green[800],
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.black87),
    hintStyle: TextStyle(color: Colors.black45),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green[900],
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 131, 87, 87)),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[900],
    labelStyle: TextStyle(color: const Color.fromARGB(179, 19, 10, 10)),
    hintStyle: TextStyle(color: Colors.white38),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(255, 77, 201, 141)),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
