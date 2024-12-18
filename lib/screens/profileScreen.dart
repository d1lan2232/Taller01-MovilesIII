import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:taller1/screens/home_screen.dart';
import 'package:taller1/screens/profileScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String email; 
  const ProfileScreen({super.key, required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isDarkMode = true; // Modo oscuro activado por defecto
  int _indice = 2; // Índice de la barra de navegación

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  String formatEmail(String email) {
    return email.replaceAll('.', '_');
  }

  void _loadUserData() async {
    String formattedEmail = formatEmail(widget.email);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$formattedEmail");

    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _emailController.text = snapshot.child('correo').value.toString(); 
        _passwordController.text = snapshot.child('contrasenia').value.toString(); 
        _nameController.text = snapshot.child('nombre').value.toString(); 
        _ageController.text = snapshot.child('edad').value.toString(); 
        _genderController.text = snapshot.child('genero').value.toString(); 
        _locationController.text = snapshot.child('ubicacion').value.toString(); 
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se encontró el usuario en la base de datos")),
      );
    }
  }

  void _saveUserData() async {
    String formattedEmail = formatEmail(widget.email);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$formattedEmail");

    Map<String, dynamic> updatedData = {};

    if (_nameController.text.isNotEmpty) {
      updatedData["nombre"] = _nameController.text;
    }
    if (_ageController.text.isNotEmpty) {
      updatedData["edad"] = _ageController.text;
    }
    if (_genderController.text.isNotEmpty) {
      updatedData["genero"] = _genderController.text;
    }
    if (_locationController.text.isNotEmpty) {
      updatedData["ubicacion"] = _locationController.text;
    }

    if (updatedData.isNotEmpty) {
      await ref.update(updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Datos actualizados exitosamente")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se realizaron cambios")),
      );
    }
  }

  void _deleteAccount() async {
    String formattedEmail = formatEmail(widget.email);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$formattedEmail");

    await ref.remove();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cuenta eliminada exitosamente")),
    );

    Navigator.pop(context); 
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _indice = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(email: widget.email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
        backgroundColor: _isDarkMode ? Colors.black : Colors.red,
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
              children: [
                const SizedBox(height: 40),
                Text(
                  'Perfil del Usuario',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.email, color: _isDarkMode ? Colors.white : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.lock, color: _isDarkMode ? Colors.white : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.person, color: _isDarkMode ? Colors.white : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Edad',
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.calendar_today, color: _isDarkMode ? Colors.white : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _genderController,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Género',
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.accessibility, color: _isDarkMode ? Colors.white : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _locationController,
                  style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Ubicación',
                    labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.location_on, color: _isDarkMode ? Colors.white : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveUserData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDarkMode ? Colors.redAccent : Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Guardar cambios',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _deleteAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDarkMode ? Colors.red : Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Eliminar cuenta',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: (value) {
          setState(() {
            _indice = value;
          });

          if (value == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(email: widget.email),
              ),
            );
          }
        },
        selectedItemColor: _isDarkMode ? Colors.redAccent : Colors.red,
        unselectedItemColor: _isDarkMode ? Colors.grey : Colors.black,
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
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
