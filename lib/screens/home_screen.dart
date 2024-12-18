import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taller1/screens/profileScreen.dart';
import 'package:taller1/screens/videoScreen.dart';
import 'package:taller1/screens/scanner.dart';  

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _peliculas = [];
  bool _isLoading = true;
  int _indice = 0;  

  @override
  void initState() {
    super.initState();
    _fetchPeliculas();
  }

  Future<void> _fetchPeliculas() async {
    final url = 'https://jritsqmet.github.io/web-api/peliculas1.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> peliculas = data['peliculas'];

        setState(() {
          _peliculas = peliculas;
          _isLoading = false;
        });
      } else {
        throw Exception('Error al cargar las películas');
      }
    } catch (e) {
      print('Error al obtener las películas: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildPeliculasList() {
    return ListView.builder(
      itemCount: _peliculas.length,
      itemBuilder: (context, index) {
        final pelicula = _peliculas[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              _playTrailer(pelicula['trailer']);
            },
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(
                pelicula['titulo'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula['descripcion'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _playTrailer(pelicula['trailer']);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Ver Tráiler',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 221, 27, 27),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              leading: pelicula['image'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        pelicula['image'],
                        width: 60,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image_not_supported, size: 60),
            ),
          ),
        );
      },
    );
  }

  void _playTrailer(String? trailerUrl) {
    if (trailerUrl != null && trailerUrl.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(trailerUrl: trailerUrl),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No trailer available for this movie.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        backgroundColor: const Color.fromARGB(255, 228, 24, 24),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(email: 'usuario@correo.com'),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildPeliculasList(),  
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: (value) {
          setState(() {
            _indice = value;
          });

          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QR()),
            );
          }
        },
        selectedItemColor: const Color.fromARGB(255, 199, 16, 16),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_rounded),
            label: "Películas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Escanear",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessible_sharp),
            label: "Página 3",
          ),
        ],
      ),
    );
  }
}
