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

  void _register() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    // Lógica para registrar usuario aquí
    // Validación de contraseñas, etc.

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cuenta creada exitosamente')),
    );
    Navigator.pop(context); // Vuelve al LoginScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro como Netflix
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        backgroundColor: Colors.transparent, // Hacer el AppBar transparente
        elevation: 0, // Eliminar sombra del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // Título de la pantalla
                const Text(
                  'Crea una cuenta nueva',
                  style: TextStyle(
                    fontSize: 32, // Tamaño de fuente mayor
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto blanco
                  ),
                ),
                const SizedBox(height: 40),
                
                // Campo de correo
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white), // Texto blanco en el campo
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'Ingresa tu correo',
                    hintStyle: const TextStyle(color: Colors.white54), // Hint en blanco
                    labelStyle: const TextStyle(color: Colors.white), // Label blanco
                    prefixIcon: const Icon(Icons.email, color: Colors.white), // Icono blanco
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.8), // Fondo oscuro del campo
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo de contraseña
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Crea tu contraseña',
                    hintStyle: const TextStyle(color: Colors.white54),
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo de confirmación de contraseña
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    hintText: 'Vuelve a escribir tu contraseña',
                    hintStyle: const TextStyle(color: Colors.white54),
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón de crear cuenta
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 229, 9, 20), // Rojo Netflix
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Crear Cuenta',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Texto de enlace a login
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Volver a la pantalla de login
                  },
                  child: const Text(
                    '¿Ya tienes cuenta? Inicia sesión',
                    style: TextStyle(
                      color: Colors.white,
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
