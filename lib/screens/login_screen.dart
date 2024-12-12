import 'package:firebase_database/firebase_database.dart';
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

 
  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu correo y contraseña.')),
      );
      return;
    }
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/" + _emailController.text);

    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      String storedPassword = snapshot.child('contrasenia').value.toString();

      if (storedPassword == _passwordController.text) {
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña incorrecta')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El correo no está registrado. ¿Quieres crear una cuenta?')),
      );
    }
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
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        actions: [
          
        ],
      ),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.network(
              'https://www.teknofilo.com/wp-content/uploads/2021/06/Netflix-1280x720.jpg', // URL de la imagen
              fit: BoxFit.cover,
            ),
          ),
        
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), 
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), 
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
                        fontSize: 36, 
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 253, 254, 255), 
                      ),
                    ),
                    const SizedBox(height: 40),
                  
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
                  
                    ElevatedButton(
                      onPressed: _login, 
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    const SizedBox(height: 10),
                  
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
