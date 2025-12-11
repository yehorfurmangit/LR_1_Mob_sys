import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/menu.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
        textTheme: GoogleFonts.latoTextTheme( 
             ThemeData.dark().textTheme,
        ),
      ),
      home: const TabsScreen(),
    );
  }
}