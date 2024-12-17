import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taller1/screens/profileScreen.dart';
import 'package:taller1/screens/videoScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _peliculas = [];
  bool _isLoading = true;

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

      for (var pelicula in peliculas) {

        if (pelicula['trailer'] == null || pelicula['trailer'].isEmpty) {

          print('Missing trailer for: ${pelicula['titulo']}');

        }

      }
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
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
     actions: [
  IconButton(
    onPressed: () {
      // Asegúrate de que estás pasando el correo del usuario (por ejemplo, de tu autenticación)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(email: 'usuario@correo.com'), // Pasa el correo dinámicamente aquí
        ),
      );
    },
    icon: Icon(Icons.person),
  ),
], ),
    
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _peliculas.length,
              itemBuilder: (context, index) {
                final pelicula = _peliculas[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5, // Sombra para la tarjeta
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Bordes redondeados
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _playTrailer("https://www.youtube.com/watch?v=YoHD9XEInc0");
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
                      subtitle: Text(
                        pelicula['descripcion'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      leading: pelicula['image'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                pelicula[
                                    'image'], // Usando la URL de la imagen desde el JSON
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
            ),
    );
  }
}


