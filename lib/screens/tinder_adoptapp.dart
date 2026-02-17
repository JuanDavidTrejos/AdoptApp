import 'package:flutter/material.dart';

class Pet {
  final String name;
  final int age;
  final String location;
  final String description;
  final List<String> traits;
  final String imageUrl;
  final String gender;

  Pet({
    required this.name,
    required this.age,
    required this.location,
    required this.description,
    required this.traits,
    required this.imageUrl,
    required this.gender,
  });
}

class PetSwipeScreen extends StatefulWidget {
  @override
  _PetSwipeScreenState createState() => _PetSwipeScreenState();
}

class _PetSwipeScreenState extends State<PetSwipeScreen> {
  int currentPetIndex = 0;
  
  final List<Pet> pets = [
    Pet(
      name: "Luna",
      age: 2,
      location: "Envigado, Medellín",
      description: "Soy una perrita muy cariñosa y juguetona. Me encanta correr en el parque y hacer nuevos amigos. Busco una familia que me dé mucho amor.",
      traits: ["Juguetona", "Cariñosa", "Activa", "Sociable"],
      imageUrl: "https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=400&h=500&fit=crop",
      gender: "♀",
    ),
    Pet(
      name: "Max",
      age: 3,
      location: "Poblado, Medellín",
      description: "Soy un perro muy leal y protector. Me gusta caminar y soy muy obediente. Perfecto para una familia que busque un compañero fiel.",
      traits: ["Leal", "Protector", "Obediente", "Tranquilo"],
      imageUrl: "https://images.unsplash.com/photo-1552053831-71594a27632d?w=400&h=500&fit=crop",
      gender: "♂",
    ),
    Pet(
      name: "Mia",
      age: 1,
      location: "Laureles, Medellín",
      description: "Soy una gatita muy curiosa y cariñosa. Me encanta jugar con pelotas y dormir en lugares cálidos. Busco una familia que me mime mucho.",
      traits: ["Curiosa", "Independiente", "Cariñosa", "Juguetona"],
      imageUrl: "https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400&h=500&fit=crop",
      gender: "♀",
    ),
  ];

  void nextPet() {
    setState(() {
      currentPetIndex = (currentPetIndex + 1) % pets.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPet = pets[currentPetIndex];

    return SafeArea(
      child: Column(
        children: [
          // Eliminado el header duplicado de 'AdoptApp'
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Age and Size badges
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '${currentPet.age} años',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.pink[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'Pequeña',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Pet Image (ajustada para evitar overflow)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            currentPet.imageUrl,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.28, // Ajusta el % según tu diseño
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: Center(child: Text('No se pudo cargar la imagen')),
                              );
                            },
                          ),
                        ),
                      ),
                      // Pet Info
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${currentPet.name} ${currentPet.age} años',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  currentPet.gender,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  currentPet.location,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Text(
                              currentPet.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 15),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: currentPet.traits.map((trait) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  trait,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Action Buttons fuera del Expanded
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reject Button
                GestureDetector(
                  onTap: nextPet,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[600],
                      size: 30,
                    ),
                  ),
                ),
                // Super Like Button
                GestureDetector(
                  onTap: nextPet,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                // Like Button
                GestureDetector(
                  onTap: nextPet,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                // Info Button
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}