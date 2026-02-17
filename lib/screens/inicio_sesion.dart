import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For TapGestureRecognizer
import 'package:url_launcher/url_launcher.dart'; // For opening URLs
import 'registro1.dart';
import 'pantalla_principal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Agregado para validaciones
  bool _passwordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false; // Initially hide password
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Custom widget for heart with paw print logo (reused from WelcomeScreen)
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

  // Helper for social login buttons (reused from WelcomeScreen)
  Widget _buildSocialButton(
      String text, IconData icon, Color iconColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for text fields with leading icons
  Widget _buildTextFieldWithIcon(String label, String hint,
      TextEditingController controller, IconData icon,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFFE53E3E), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? !_passwordVisible : false,
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor completa este campo';
            }
            if (label == 'Correo electrónico') {
              // Validación más robusta para email
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Por favor ingresa un email válido';
              }
            }
            if (label == 'Contraseña') {
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF7B7B)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
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
          child: SingleChildScrollView(
            // Allows scrolling if content overflows
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Form(
                // Envolvemos en Form para las validaciones
                key: _formKey,
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Take minimum space vertically
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7B7B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on,
                              color: Color(0xFFFF7B7B), size: 18),
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
                      'Iniciar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    const Text(
                      'Accede a tu cuenta para descubrir\nmascotas increíbles',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Social Login Buttons
                    _buildSocialButton(
                      'Continuar con Google',
                      Icons.g_mobiledata, // Using g_mobiledata for Google icon
                      Colors.red,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Continuar con Google')),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildSocialButton(
                      'Continuar con Facebook',
                      Icons.facebook,
                      Colors.blue,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Continuar con Facebook')),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    const Text(
                      'O INICIA CON EMAIL',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    _buildTextFieldWithIcon(
                      'Correo electrónico',
                      'tu@email.com',
                      _emailController,
                      Icons.mail,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    _buildTextFieldWithIcon(
                      'Contraseña',
                      'Tu contraseña',
                      _passwordController,
                      Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password and Remember Me
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _rememberMe = newValue!;
                                });
                              },
                              activeColor: const Color(0xFFFF7B7B),
                            ),
                            const Text(
                              'Recordar mi sesión',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 16), // Aumenta este valor para más espacio
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Olvidaste tu contraseña?')),
                              );
                            },
                            child: const Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(
                                color: Color(0xFFE53E3E),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              // Mostrar indicador de carga
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Iniciando sesión...'),
                                  backgroundColor: Colors.blue,
                                ),
                              );

                              // Intentar autenticar con Firebase
                              final UserCredential userCredential =
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              // Si la autenticación es exitosa
                              if (userCredential.user != null) {
                                // Limpiar el SnackBar anterior
                                ScaffoldMessenger.of(context).clearSnackBars();

                                // Mostrar mensaje de éxito
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('¡Inicio de sesión exitoso!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Navegar a la pantalla principal
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeFeedScreen()),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              // Manejar errores específicos de Firebase Auth
                              String errorMessage =
                                  'Ocurrió un error al iniciar sesión';

                              if (e.code == 'user-not-found') {
                                errorMessage =
                                    'No existe una cuenta con este correo';
                              } else if (e.code == 'wrong-password') {
                                errorMessage = 'Contraseña incorrecta';
                              } else if (e.code == 'invalid-email') {
                                errorMessage =
                                    'El formato del correo es inválido';
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } catch (e) {
                              // Manejar otros errores
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Por favor corrige los errores en el formulario'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.zero,
                        ).copyWith(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white.withOpacity(0.2);
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
                                Color(0xFFFF7B7B),
                                Color(0xFFE53E3E),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_forward,
                                    color: Colors.white, size: 24),
                                SizedBox(width: 12),
                                Text(
                                  'Iniciar Sesión',
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

                    // Don't have an account? Register here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿No tienes cuenta? ',
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to RegistrationScreen (registro1.dart)
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        RegistrationScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var slideTween =
                                      Tween(begin: begin, end: end).chain(
                                    CurveTween(curve: curve),
                                  );

                                  return SlideTransition(
                                    position: animation.drive(slideTween),
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                              ),
                            );
                          },
                          child: const Text(
                            'Regístrate aquí',
                            style: TextStyle(
                              color: Color(0xFFE53E3E), // Darker red
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
                            const TextSpan(
                                text: 'Al iniciar sesión, aceptas nuestros '),
                            TextSpan(
                              text: 'Términos de Servicio',
                              style: const TextStyle(
                                color: Color(0xFFE53E3E),
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri url = Uri.parse(
                                      'https://example.com/terms'); // Replace with actual URL
                                  if (!await launchUrl(url)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'No se pudo abrir la URL: $url')),
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
                                  final Uri url = Uri.parse(
                                      'https://example.com/privacy'); // Replace with actual URL
                                  if (!await launchUrl(url)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'No se pudo abrir la URL: $url')),
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
      ),
    );
  }
}
