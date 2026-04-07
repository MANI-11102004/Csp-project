import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_page.dart';
import 'screens/language_selection.dart';
import 'screens/home_page.dart';
import 'screens/settings_page.dart';
import 'screens/thank_you_page.dart';

void main() {
  runApp(DigitalLiteracyApp());
}

class DigitalLiteracyApp extends StatefulWidget {
  @override
  State<DigitalLiteracyApp> createState() => _DigitalLiteracyAppState();
}

class _DigitalLiteracyAppState extends State<DigitalLiteracyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Literacy App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/language': (context) => LanguageSelection(),
        '/home': (context) => HomePage(
          isDarkMode: _themeMode == ThemeMode.dark,
          onThemeChanged: _toggleTheme,
        ),
        '/settings': (context) => SettingsPage(
          isDarkMode: _themeMode == ThemeMode.dark,
          onThemeChanged: _toggleTheme,
        ),
        '/thankyou': (context) => ThankYouPage(),
      },
    );
  }
}
