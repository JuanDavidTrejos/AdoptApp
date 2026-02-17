import 'package:flutter/material.dart';
import 'eventos.dart';
import 'tinder_adoptapp.dart';
import 'perfil_usuario.dart';
import 'fundaciones.dart';


class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int _selectedIndex = 0;

  // Lista de páginas reales para la BottomNavBar
  static final List<Widget> _widgetOptions = <Widget>[
    HomeContentScreen(), // Widget para el contenido principal del Home
    EventsScreen(),
    PetSwipeScreen(),
    FundacionesScreen(), // Pantalla de Fundaciones - cambiar por mensajes
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Helper para los botones de filtro
  Widget _buildFilterButton(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(text),
        backgroundColor:
            isSelected ? const Color(0xFFE53E3E) : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }

  // Helper para una tarjeta de publicación individual
  Widget _buildPostCard(String username, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.blue,
                        width: 2), // Borde azul como en la imagen
                  ),
                  // Placeholder para avatar
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue, // Texto azul como en la imagen
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(
                    15)), // Solo esquinas inferiores redondeadas para la imagen
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 300, // Altura fija para demostración
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $imagePath - $error'); // Debug info
                return Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Error al cargar imagen',
                            style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // Fondo transparente para que se vea el degradado del body
        elevation: 0,
        automaticallyImplyLeading: false, // Elimina el botón de retroceso
        title: const Text(
          'AdoptApp',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: _widgetOptions[_selectedIndex], // Cambia la pantalla según el índice
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2), // Índice para el feed de Tinder
        backgroundColor: const Color(0xFFE53E3E), // Rojo más oscuro
        shape: const CircleBorder(),
        elevation: 8,
        child: const Icon(Icons.favorite,
            color: Colors.white, size: 30), // Icono de corazón
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE53E3E), // Rojo más oscuro para la barra
        shape: const CircularNotchedRectangle(), // Para el "notch" del FAB
        notchMargin: 8.0, // Margen del notch
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0
                      ? Colors.white
                      : Colors.white.withOpacity(0.7)),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today,
                  color: _selectedIndex == 1
                      ? Colors.white
                      : Colors.white.withOpacity(0.7)),
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 48), // Espacio para el FAB
            IconButton(
              icon: Icon(Icons.message,
                  color: _selectedIndex == 3
                      ? Colors.white
                      : Colors.white.withOpacity(0.7)),
              onPressed: () => _onItemTapped(3),
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 4
                      ? Colors.white
                      : Colors.white.withOpacity(0.7)),
              onPressed: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}

// Nuevo widget para el contenido principal del Home
class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({Key? key}) : super(key: key);

  // Copia aquí el contenido original del body de HomeFeedScreen
  // Helper para los botones de filtro
  Widget _buildFilterButton(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(text),
        backgroundColor:
            isSelected ? const Color(0xFFE53E3E) : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }

  // Helper para una tarjeta de publicación individual
  Widget _buildPostCard(String username, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.blue,
                        width: 2),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $imagePath - $error'); // Debug info
                return Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Error al cargar imagen',
                            style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFF7B7B),
            Color(0xFFE53E3E),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              '¡Llena de amor tu vida!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterButton('Todo', true),
                _buildFilterButton('Fundaciones', false),
                _buildFilterButton('Información', false),
                _buildFilterButton('Hola', false),
                _buildFilterButton('Más', false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildPostCard('refugio_esperanza',
                    'assets/images/Perro_gato.jpg'),
                _buildPostCard('fundacion_patitas',
                    'assets/images/perro_gato2.jpg'),
                _buildPostCard('amigos_peludos',
                    'assets/images/Perro_gato.jpg'),
                _buildPostCard('adopta_con_amor',
                    'assets/images/perro_gato2.jpg'),
                _buildPostCard('hogar_temporal',
                    'assets/images/Perro_gato.jpg'),
                // Añade más tarjetas de publicaciones aquí
              ],
            ),
          ),
        ],
      ),
    );
  }
}
