import 'dart:convert';  // Importa el paquete para trabajar con JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _peliculas.length,
              itemBuilder: (context, index) {
                final pelicula = _peliculas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5, // Sombra para la tarjeta
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  ),
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
                              pelicula['image'], // Usando la URL de la imagen desde el JSON
                              width: 60,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image_not_supported, size: 60),
                  ),
                );
              },
            ),
    );
  }
}
