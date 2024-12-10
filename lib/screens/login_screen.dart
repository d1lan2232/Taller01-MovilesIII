import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'crear_cuenta_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Mostrar un mensaje si los campos están vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu correo y contraseña.')),
      );
      return;
    }

    // Lógica de autenticación aquí

    // Si todo es válido, navegamos a la pantalla principal
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _goToCrearCuenta() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrearCuentaScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.network(
              'https://www.teknofilo.com/wp-content/uploads/2021/06/Netflix-1280x720.jpg', // URL de la imagen
              fit: BoxFit.cover, // Ajuste de la imagen para cubrir toda la pantalla
            ),
          ),
          // Fondo oscuro con opacidad para que el contenido sea legible
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Filtro oscuro
            ),
          ),
          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ajuste de los márgenes
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 36, // Tamaño de fuente mayor
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 253, 254, 255), // Color atractivo
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Campo de correo
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        hintText: 'Ingresa tu correo',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 13, 13, 13)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de contraseña
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Ingresa tu contraseña',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Botón de Login
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 3, 3), // Color de fondo
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Texto de no cuenta
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Enlace a Crear cuenta
                    TextButton(
                      onPressed: _goToCrearCuenta,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Text(
                        'Crea una cuenta',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 250, 0, 0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
