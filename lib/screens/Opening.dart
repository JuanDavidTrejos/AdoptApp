import 'package:flutter/material.dart';
import 'pantalla_inicio.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800), // Fade duration
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF7B7B), // Lighter red from your example
              Color(0xFFE53E3E), // Darker red from your example
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AdoptApp Title
              const Text(
                'AdoptApp',
                style: TextStyle(
                  fontFamily: 'Lobster', // Use the Lobster font
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Heart with Paw Print Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // Slightly transparent white background
                  shape: BoxShape.circle,
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 60,
                      color: Colors.white,
                    ),
                    Positioned(
                      child: Icon(
                        Icons.pets,
                        size: 30,
                        color: Color(0xFFE53E3E), // Red paw inside white heart
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Tagline
              Text(
                'Adopta amor,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily, // Use a standard font for this text
                ),
              ),
              Text(
                'cambia una vida.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontStyle: FontStyle.italic, // Italic for "cambia una vida"
                  fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily, // Use a standard font for this text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

