import 'package:adopt_app/screens/pantalla_principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CompleteRegistrationScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> petPreferences;

  const CompleteRegistrationScreen({
    Key? key,
    required this.userData,
    required this.petPreferences,
  }) : super(key: key);

  @override
  _CompleteRegistrationScreenState createState() => _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState extends State<CompleteRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _passwordsMatch = false;
  
  bool _acceptDataTreatment = false;
  bool _acceptTermsAndConditions = false;
  bool _acceptPrivacyPolicy = false;
  bool _acceptNotifications = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePasswordMatch);
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
    });
    _validatePasswordMatch();
  }

  void _validatePasswordMatch() {
    setState(() {
      _passwordsMatch = _passwordController.text == _confirmPasswordController.text && 
                      _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF7B7B),
              Color(0xFFE53E3E),
            ],
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                // Header with back button and progress bar
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back, 
                                color: Color(0xFFFF7B7B),
                                size: 28,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      // Progress bar
                      Container(
                        height: 4,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: LinearProgressIndicator(
                          value: 0.9,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7B7B)),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo and title
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF7B7B),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 24),
                                
                                Text(
                                  'Completa tu registro',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                
                                Text(
                                  'Solo faltan unos pasos para unirte a nuestra\ncomunidad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32),
                          
                          // Password Section
                          Row(
                            children: [
                              Icon(Icons.key, color: Color(0xFFFF7B7B), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Contraseña',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Crea una contraseña segura',
                              hintStyle: TextStyle(color: Colors.black54),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
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
                                borderSide: BorderSide(color: Color(0xFFFF7B7B)),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                          ),
                          SizedBox(height: 16),
                          
                          // Password requirements
                          _buildRequirement('Mínimo 8 caracteres', _hasMinLength),
                          _buildRequirement('Una letra mayúscula', _hasUppercase),
                          _buildRequirement('Un número', _hasNumber),
                          SizedBox(height: 24),
                          
                          // Confirm Password Section
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: Color(0xFFFF7B7B), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Confirmar contraseña',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Confirma tu contraseña',
                              hintStyle: TextStyle(color: Colors.black54),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
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
                                borderSide: BorderSide(color: Color(0xFFFF7B7B)),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                          ),
                          SizedBox(height: 8),
                          
                          if (_confirmPasswordController.text.isNotEmpty && !_passwordsMatch)
                            Row(
                              children: [
                                Icon(Icons.close, color: Color(0xFFFF7B7B), size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Las contraseñas deben coincidir',
                                  style: TextStyle(
                                    color: Color(0xFFFF7B7B),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 32),
                          
                          // Terms and Conditions Section
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.description, color: Color(0xFFFF7B7B), size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Términos y condiciones',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                
                                _buildCheckboxTile(
                                  'Acepto el tratamiento de mis datos personales según la Ley 1581 de 2012 de Colombia',
                                  _acceptDataTreatment,
                                  (value) => setState(() => _acceptDataTreatment = value!),
                                ),
                                
                                _buildCheckboxTile(
                                  'Acepto los términos y condiciones de servicio de AdoptApp Medellín',
                                  _acceptTermsAndConditions,
                                  (value) => setState(() => _acceptTermsAndConditions = value!),
                                ),
                                
                                _buildCheckboxTile(
                                  'He leído y acepto la política de privacidad',
                                  _acceptPrivacyPolicy,
                                  (value) => setState(() => _acceptPrivacyPolicy = value!),
                                ),
                                
                                _buildCheckboxTile(
                                  'Deseo recibir notificaciones por email sobre nuevas mascotas y actualizaciones (opcional)',
                                  _acceptNotifications,
                                  (value) => setState(() => _acceptNotifications = value!),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32),
                          
                          // Complete Registration button with gradient and animation
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _canCompleteRegistration() ? () {
                                _completeRegistration();
                              } : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ).copyWith(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: _canCompleteRegistration() ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFF7B7B),
                                      Color(0xFFE53E3E),
                                    ],
                                  ) : null,
                                  color: _canCompleteRegistration() ? null : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle, 
                                        color: _canCompleteRegistration() ? Colors.white : Colors.grey[600]
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Completar registro',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: _canCompleteRegistration() ? Colors.white : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isValid) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check : Icons.close,
            color: Color(0xFFFF7B7B),
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFFFF7B7B),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String text, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFFFF7B7B),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    height: 1.4,
                  ),
                  children: [
                    if (text.contains('tratamiento'))
                      TextSpan(
                        children: [
                          TextSpan(text: 'Acepto el '),
                          TextSpan(
                            text: 'tratamiento de mis datos personales',
                            style: TextStyle(
                              color: Color(0xFFFF7B7B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: ' según la Ley 1581 de 2012 de Colombia'),
                        ],
                      )
                    else if (text.contains('términos'))
                      TextSpan(
                        children: [
                          TextSpan(text: 'Acepto los '),
                          TextSpan(
                            text: 'términos y condiciones de servicio',
                            style: TextStyle(
                              color: Color(0xFFFF7B7B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: ' de AdoptApp Medellín'),
                        ],
                      )
                    else if (text.contains('política'))
                      TextSpan(
                        children: [
                          TextSpan(text: 'He leído y acepto la '),
                          TextSpan(
                            text: 'política de privacidad',
                            style: TextStyle(
                              color: Color(0xFFFF7B7B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    else
                      TextSpan(text: text),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canCompleteRegistration() {
    return _hasMinLength &&
           _hasUppercase &&
           _hasNumber &&
           _passwordsMatch &&
           _acceptDataTreatment &&
           _acceptTermsAndConditions &&
           _acceptPrivacyPolicy;
  }

  // 🎉 AQUÍ ESTÁ LA FUNCIÓN CORREGIDA CON EL POPUP HERMOSO
Future<void> _completeRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Crear usuario en Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.userData['email'],
        password: _passwordController.text,
      );

      // Guardar datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': widget.userData['name'],
        'email': widget.userData['email'],
        'lastName': widget.userData['lastName'], 
        'phone': widget.userData['phone'],
        'birthDate': widget.userData['birthDate'],   // Fecha de nacimiento
        'userType': widget.userData['userType'], 
        'petPreferences': widget.petPreferences,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Mostrar popup de éxito
      _showBeautifulSuccessPopup();
    } catch (e) {
      print('Error al completar el registro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al completar el registro. Inténtalo de nuevo.')),
      );
    }
  }


  // 🌟 POPUP HERMOSO Y PROFESIONAL
  void _showBeautifulSuccessPopup() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 320,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Espaciado superior
              SizedBox(height: 40),
              
              // Icono de éxito simple y elegante
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: 24),
              
              // Título simple
              Text(
                '¡Registro Exitoso!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              SizedBox(height: 12),
              
              // Mensaje personalizado simple
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: 'Bienvenido '),
                      TextSpan(
                        text: '${widget.userData['name']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7B7B),
                        ),
                      ),
                      TextSpan(text: '! 🎉\n\nYa puedes comenzar a buscar tu compañero perfecto.'),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 32),
              
              // Botón principal simple
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _navigateToMainApp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF7B7B),
                            Color(0xFFE53E3E),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Comenzar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Botón secundario simple
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Editar perfil',
                  style: TextStyle(
                    color: Color(0xFFFF7B7B),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              SizedBox(height: 24),
            ],
          ),
        ),
      );
    },
  );
}

  // Helper para mostrar información del usuario
  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.black54),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Navegación a la app principal
void _navigateToMainApp() {
  // Primero mostramos la pantalla de transición
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        // Después de 2 segundos, navegamos a HomeFeedScreen
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeFeedScreen()),
          );
        });

        // Mientras tanto mostramos la pantalla de carga
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF7B7B),
                  Color(0xFFE53E3E),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 70,
                            color: Color(0xFFFF7B7B),
                          ),
                        ),
                        Positioned(
                          child: Icon(
                            Icons.pets,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  
                  Text(
                    'AdoptApp',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Lobster',
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Text(
                    '¡Bienvenido ${widget.userData['name']}!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  Text(
                    'Tu registro se completó exitosamente\nComienza a explorar mascotas disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 48),
                  
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 16),
                  
                  Text(
                    'Cargando tu experiencia...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var slideTween = Tween(begin: begin, end: end).chain(
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
      transitionDuration: Duration(milliseconds: 400),
    ),
  );
}

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
