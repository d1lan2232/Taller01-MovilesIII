import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CrearCuentaScreen extends StatefulWidget {
  const CrearCuentaScreen({super.key});

  @override
  State<CrearCuentaScreen> createState() => _CrearCuentaScreenState();
}

class _CrearCuentaScreenState extends State<CrearCuentaScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isDarkMode = false;

  // Función para alternar entre modo oscuro y claro
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _register() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    guardar(_emailController.text, _passwordController.text, _nameController.text, _ageController.text, _genderController.text, _locationController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cuenta creada exitosamente')),
    );

    Navigator.pop(context); 
  }

  Future<void> guardar(String correo, String contrasenia, String nombre, String edad, String genero, String ubicacion) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/" + correo);

      await ref.set({
        "correo": correo,
        "contrasenia": contrasenia,
        "nombre": nombre,
        "edad": edad,
        "genero": genero,
        "ubicacion": ubicacion,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Datos guardados exitosamente")),
      );
    } catch (e) {
      print("Error al guardar los datos: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al guardar los datos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Crear Cuenta',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // Icono de flecha de retroceso
            color: _isDarkMode ? Colors.white : Colors.black, // Cambiar el color de la flecha
          ),
          onPressed: () {
            Navigator.pop(context); // Retroceder a la pantalla anterior
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: _isDarkMode ? Colors.yellow : Colors.black,
            ),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Crea una cuenta nueva',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black, 
                  ),
                ),
                const SizedBox(height: 40),
                // Nuevo campo: Nombre
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Ingresa tu nombre',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.person, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nuevo campo: Edad
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Edad',
                    hintText: 'Ingresa tu edad',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nuevo campo: Género
                TextField(
                  controller: _genderController,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Género',
                    hintText: 'Ingresa tu género',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.accessibility, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nuevo campo: Ubicación
                TextField(
                  controller: _locationController,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Dónde vives',
                    hintText: 'Ingresa tu ubicación',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.location_on, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'Ingresa tu correo',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.email, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Crea tu contraseña',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.lock, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    hintText: 'Vuelve a escribir tu contraseña',
                    hintStyle: TextStyle(color: _isDarkMode ? Colors.white54 : Colors.black54),
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.lock, color: _isDarkMode ? Colors.white : Colors.black),
                    filled: true,
                    fillColor: _isDarkMode ? Colors.black.withOpacity(0.8) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDarkMode ? Colors.redAccent : const Color.fromARGB(255, 233, 82, 82), 
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Crear Cuenta',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '¿Ya tienes cuenta? Inicia sesión',
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
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
}
