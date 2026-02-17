import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening URLs
import 'registro1.dart';
import 'inicio_sesion.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Custom widget for heart with paw print logo
  Widget _buildHeartWithPawLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFF7B7B).withOpacity(0.1), // Light red background
        shape: BoxShape.circle,
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 50,
            color: Color(0xFFFF7B7B), // Red heart
          ),
          Positioned(
            child: Icon(
              Icons.pets,
              size: 24,
              color: Colors.white, // White paw inside heart
            ),
          ),
        ],
      ),
    );
  }

  // Helper for feature cards
  Widget _buildFeatureCard(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFF7B7B).withOpacity(0.1), // Light red background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF7B7B), size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFFE53E3E), // Darker red text
              ),
            ),
          ),
        ],
      ),
    );
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
              Color(0xFFFF7B7B), // Lighter red
              Color(0xFFE53E3E), // Darker red
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView( // Allows scrolling if content overflows
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Take minimum space vertically
                children: [
                  // Logo
                  _buildHeartWithPawLogo(),
                  const SizedBox(height: 16),

                  // AdoptApp title
                  const Text(
                    'AdoptApp',
                    style: TextStyle(
                      fontFamily: 'Lobster', // Use the Lobster font
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7B7B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: Color(0xFFFF7B7B), size: 18),
                        SizedBox(width: 4),
                        Text(
                          'Medellín',
                          style: TextStyle(
                            color: Color(0xFFFF7B7B),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Main Heading
                  const Text(
                    'Encuentra tu\ncompañero perfecto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'Conectamos corazones y creamos\nfamilias felices en Medellín',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Feature Cards
                  _buildFeatureCard(Icons.pets, 'Desliza y encuentra tu mascota ideal'),
                  _buildFeatureCard(Icons.verified_user, 'Fundaciones verificadas y confiables'),
                  _buildFeatureCard(Icons.favorite, 'Adopciones responsables y seguras'),
                  const SizedBox(height: 32),

                  // Create New Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => RegistrationScreen(), // Tu pantalla de registro
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Empieza desde la derecha
                              const end = Offset.zero; // Termina en el centro
                              const curve = Curves.easeInOut;

                              var slideTween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );

                              return SlideTransition(
                                position: animation.drive(slideTween),
                                child: FadeTransition( // Añade un desvanecimiento
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 400), // Duración de la transición
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Make button transparent to show gradient
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.zero, // Remove default padding
                      ).copyWith(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white.withOpacity(0.2); // Ripple effect
                            }
                            return null;
                          },
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFF7B7B), // Lighter red
                              Color(0xFFE53E3E), // Darker red
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add, color: Colors.white, size: 24),
                              SizedBox(width: 12),
                              Text(
                                'Crear cuenta nueva',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Already Have Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        // Navegar a la pantalla de inicio de sesión
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()), // O PageRouteBuilder para una transición personalizada
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward, color: Color(0xFFE53E3E), size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Ya tengo cuenta',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Terms and Privacy Policy
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        children: [
                          const TextSpan(text: 'Al continuar, aceptas nuestros '),
                          TextSpan(
                            text: 'Términos de Servicio',
                            style: const TextStyle(
                              color: Color(0xFFE53E3E),
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final Uri url = Uri.parse('https://example.com/terms'); // Replace with actual URL
                                if (!await launchUrl(url)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('No se pudo abrir la URL: $url')),
                                  );
                                }
                              },
                          ),
                          const TextSpan(text: ' y\n'),
                          TextSpan(
                            text: 'Política de Privacidad',
                            style: const TextStyle(
                              color: Color(0xFFE53E3E),
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final Uri url = Uri.parse('https://example.com/privacy'); // Replace with actual URL
                                if (!await launchUrl(url)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('No se pudo abrir la URL: $url')),
                                  );
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

