import 'package:flutter/material.dart';
import 'registro3.dart';

class PetPreferencesScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const PetPreferencesScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _PetPreferencesScreenState createState() => _PetPreferencesScreenState();
}

class _PetPreferencesScreenState extends State<PetPreferencesScreen> {
  String? selectedPetType;
  String? selectedSize;
  List<String> selectedAges = [];
  List<String> selectedCharacteristics = [];

  final List<Map<String, dynamic>> petTypes = [
    {'name': 'Perros', 'emoji': '🐕'},
    {'name': 'Gatos', 'emoji': '🐱'},
    {'name': 'Conejos', 'emoji': '🐰'},
    {'name': 'Aves', 'emoji': '🐦'},
  ];

  final List<String> sizes = ['Pequeño', 'Mediano', 'Grande'];
  
  final List<String> ages = ['Cachorro', 'Joven', 'Adulto', 'Anciano'];
  
  final List<Map<String, dynamic>> characteristics = [
    {'name': 'Juguetón', 'icon': Icons.play_arrow},
    {'name': 'Tranquilo', 'icon': Icons.spa},
    {'name': 'Sociable', 'icon': Icons.groups},
    {'name': 'Independiente', 'icon': Icons.terrain},
    {'name': 'Activo', 'icon': Icons.directions_run},
    {'name': 'Cariñoso', 'icon': Icons.favorite},
  ];

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
                          value: 0.6,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo and title
                        Center(
                          child: Column(
                            children: [
                              // Heart with paw logo
                              _buildHeartWithPawLogo(),
                              SizedBox(height: 24),
                              
                              Text(
                                '¿Qué mascota buscas?',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              
                              Text(
                                'Cuéntanos tus preferencias para encontrar tu\ncompañero ideal',
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
                        
                        // Pet Type Section
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Color(0xFFFF7B7B), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Tipo de mascota',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: petTypes.length,
                          itemBuilder: (context, index) {
                            final petType = petTypes[index];
                            final isSelected = selectedPetType == petType['name'];
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPetType = petType['name'];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? Color(0xFFFF7B7B).withOpacity(0.1) : Colors.grey[50],
                                  border: Border.all(
                                    color: isSelected ? Color(0xFFFF7B7B) : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      petType['emoji'],
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      petType['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Color(0xFFFF7B7B) : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 32),
                        
                        // Size Section
                        Row(
                          children: [
                            Icon(Icons.straighten, color: Color(0xFFFF7B7B), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Tamaño preferido',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        Row(
                          children: sizes.map((size) {
                            final isSelected = selectedSize == size;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: isSelected ? Color(0xFFFF7B7B).withOpacity(0.1) : Colors.grey[50],
                                      border: Border.all(
                                        color: isSelected ? Color(0xFFFF7B7B) : Colors.grey[300]!,
                                        width: isSelected ? 2 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Center(
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected ? Color(0xFFFF7B7B) : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 32),
                        
                        // Age Section
                        Row(
                          children: [
                            Icon(Icons.cake, color: Color(0xFFFF7B7B), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Edad preferida',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ages.map((age) {
                            final isSelected = selectedAges.contains(age);
                            final isAnciano = age == 'Anciano';
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedAges.remove(age);
                                  } else {
                                    selectedAges.add(age);
                                  }
                                });
                              },
                              child: Container(
                                width: isAnciano ? double.infinity : (MediaQuery.of(context).size.width - 80) / 3,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: isSelected ? Color(0xFFFF7B7B).withOpacity(0.1) : Colors.grey[50],
                                  border: Border.all(
                                    color: isSelected ? Color(0xFFFF7B7B) : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    age,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Color(0xFFFF7B7B) : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 32),
                        
                        // Characteristics Section
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFFF7B7B), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Características deseadas',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: characteristics.length,
                          itemBuilder: (context, index) {
                            final characteristic = characteristics[index];
                            final isSelected = selectedCharacteristics.contains(characteristic['name']);
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedCharacteristics.remove(characteristic['name']);
                                  } else {
                                    selectedCharacteristics.add(characteristic['name']);
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? Color(0xFFFF7B7B).withOpacity(0.1) : Colors.grey[50],
                                  border: Border.all(
                                    color: isSelected ? Color(0xFFFF7B7B) : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      characteristic['icon'],
                                      size: 20,
                                      color: isSelected ? Color(0xFFFF7B7B) : Colors.black54,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      characteristic['name'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Color(0xFFFF7B7B) : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 32),
                        
                        // Continue button with gradient and animation
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to final screen with animation
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => CompleteRegistrationScreen(
                                    userData: widget.userData,
                                    petPreferences: {
                                      'petType': selectedPetType,
                                      'size': selectedSize,
                                      'ages': selectedAges,
                                      'characteristics': selectedCharacteristics,
                                    },
                                  ),
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
                            },
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
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFFF7B7B),
                                    Color(0xFFE53E3E),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Continuar',
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
                      ],
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

  // Custom widget for heart with paw print logo
  Widget _buildHeartWithPawLogo() {
    return Container(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Heart background
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFFFF7B7B).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite,
              size: 50,
              color: Color(0xFFFF7B7B),
            ),
          ),
          // Paw print overlay - DENTRO del corazón
          Positioned(
            child: Icon(
              Icons.pets,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}