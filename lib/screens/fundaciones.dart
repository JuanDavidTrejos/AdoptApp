import 'package:flutter/material.dart';


class FundacionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFE53E3E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fundaciones',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Medellín, Colombia',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Buscar fundaciones...',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Statistics Row
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('47', 'Fundaciones'),
                          _buildStatItem('1,234', 'Mascotas'),
                          _buildStatItem('892', 'Adoptadas'),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Verified Foundations Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fundaciones verificadas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Ver todas',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.pink[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Foundation Cards
                    _buildFoundationCard(
                      name: 'Fundación Corazones Peludos',
                      location: 'El Poblado, Medellín',
                      rating: 4.9,
                      reviews: 127,
                      pets: 89,
                      since: 2018,
                      adoptions: 234,
                      description:
                          'Nos dedicamos al rescate y rehabilitación de perros y gatos en situación de calle. Trabajamos con amor y dedicación para encontrar hogares responsables.',
                      icon: Icons.favorite,
                      iconColor: Colors.pink,
                    ),

                    SizedBox(height: 16),

                    _buildFoundationCard(
                      name: 'Refugio Esperanza Animal',
                      location: 'Laureles, Medellín',
                      rating: 4.7,
                      reviews: 89,
                      pets: 156,
                      since: 2015,
                      adoptions: 512,
                      description:
                          'Refugio especializado en animales con necesidades especiales. Brindamos atención veterinaria integral y programas de rehabilitación.',
                      icon: Icons.pets,
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container( // This section has been removed
      //   height: 80,
      //   decoration: BoxDecoration(
      //     color: Colors.pink[600],
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(25),
      //       topRight: Radius.circular(25),
      //     ),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       _buildBottomNavItem(Icons.home, true),
      //       _buildBottomNavItem(Icons.calendar_today, false),
      //       // Floating Action Button
      //       Container(
      //         padding: EdgeInsets.all(12),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           shape: BoxShape.circle,
      //         ),
      //         child: Icon(
      //           Icons.location_on,
      //           color: Colors.pink[600],
      //           size: 28,
      //         ),
      //       ),
      //       _buildBottomNavItem(Icons.chat_bubble_outline, false),
      //       _buildBottomNavItem(Icons.person_outline, false),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pink[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFoundationCard({
    required String name,
    required String location,
    required double rating,
    required int reviews,
    required int pets,
    required int since,
    required int adoptions,
    required String description,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: Colors.grey[500]),
                        SizedBox(width: 4),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 12, color: Colors.green[600]),
                    SizedBox(width: 4),
                    Text(
                      'Verificada',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Rating
          Row(
            children: [
              ...List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        size: 16,
                        color: index < rating.floor()
                            ? Colors.amber
                            : Colors.grey[300],
                      )),
              SizedBox(width: 8),
              Text(
                '$rating ($reviews reseñas)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Stats
          Row(
            children: [
              _buildCardStat(Icons.pets, pets.toString(), 'mascotas'),
              SizedBox(width: 20),
              _buildCardStat(Icons.calendar_today, 'Desde\n$since', ''),
              SizedBox(width: 20),
              _buildCardStat(
                  Icons.favorite, adoptions.toString(), 'adopciones'),
            ],
          ),

          SizedBox(height: 12),

          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),

          SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye, size: 16),
                  label: Text('Ver mascotas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE53E3E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.phone, size: 16),
                  label: Text('Contactar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pink[600],
                    elevation: 0,
                    side: BorderSide(color: Colors.pink[600]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardStat(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (label.isNotEmpty)
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Widget _buildBottomNavItem(IconData icon, bool isActive) { // This function is no longer needed
  //   return Icon(
  //     icon,
  //     color: isActive ? Colors.white : Colors.white.withOpacity(0.6),
  //     size: 24,
  //   );
  // }
}
