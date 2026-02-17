import 'package:flutter/material.dart';
import 'resumen_evento.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  // Helper para el encabezado de la sección de eventos
  Widget _buildSectionHeader(String title, {String? actionText, VoidCallback? onActionTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE53E3E), // Rojo de la marca
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper para una tarjeta de evento/fundación
  Widget _buildEventCard(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String location,
      required double rating,
      required int reviews,
      required int pets,
      required String sinceYear,
      required int adoptions,
      required String description,
      required bool isVerified,
    }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E), // Rojo de la marca
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isVerified)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.green[100], // Fondo verde claro
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.green[700], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Verificada',
                          style: TextStyle(color: Colors.green[700], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber[600], size: 18),
                Text(
                  '$rating ($reviews reseñas)',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.pets, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text('$pets mascotas', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text('Desde $sinceYear', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.grey, size: 16), // Icono de adopciones
                    const SizedBox(width: 4),
                    Text('$adoptions adopciones', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventSummaryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.remove_red_eye, size: 20),
                    label: const Text('Ver información'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53E3E), // Rojo de la marca
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Lógica para contactar
                    },
                    icon: const Icon(Icons.call, size: 20),
                    label: const Text('Contactar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE53E3E), // Rojo de la marca
                      side: const BorderSide(color: Color(0xFFE53E3E)), // Borde rojo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Usa Container en lugar de Scaffold si este es un body para el shell
      decoration: const BoxDecoration(
        color: Color(0xFFFFF0F0), // Fondo rosa muy claro para EventsScreen
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado de la pantalla de eventos
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.calendar_month, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Eventos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Antioquia, Colombia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar Eventos...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFFF7B7B)),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Sección de eventos verificados
          _buildSectionHeader(
            'Eventos verificados',
            actionText: 'Ver todas',
            onActionTap: () {
              // Lógica para ver todos los eventos
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero, // Elimina el padding predeterminado del ListView
              children: [
                _buildEventCard(
                  context,
                  icon: Icons.favorite,
                  title: 'Adoptatón Patitas',
                  location: 'Envigado, Medellín',
                  rating: 4.9,
                  reviews: 127,
                  pets: 89,
                  sinceYear: '2018',
                  adoptions: 234,
                  description:
                      'Nos dedicamos al rescate y rehabilitación de perros y gatos en situación de calle. Trabajamos con amor y dedicación para encontrar hogares responsables.',
                  isVerified: true,
                ),
                _buildEventCard(
                  context,
                  icon: Icons.shield,
                  title: 'Ronda adopción La Huella',
                  location: 'Laureles, Medellín',
                  rating: 4.7,
                  reviews: 89,
                  pets: 156,
                  sinceYear: '2015',
                  adoptions: 412,
                  description:
                      'Adopción especializadah en animales con necesidades especiales. Brindamos atención veterinaria integral y programas de rehabilitación.',
                  isVerified: true,
                ),
                // Puedes añadir más tarjetas de eventos aquí
              ],
            ),
          ),
        ],
      ),
    );
  }
}