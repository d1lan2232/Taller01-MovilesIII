import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String email; // Recibe el correo del usuario que está logueado
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
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Función para formatear el correo (remover puntos para Firebase)
  String formatEmail(String email) {
    return email.replaceAll('.', '_');
  }

  // Cargar los datos del usuario desde Firebase al cargar la pantalla
  void _loadUserData() async {
    String formattedEmail = formatEmail(widget.email);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$formattedEmail");

    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _emailController.text = snapshot.child('correo').value.toString(); // Correo
        _passwordController.text = snapshot.child('contrasenia').value.toString(); // Contraseña
        _nameController.text = snapshot.child('nombre').value.toString(); // Nombre
        _ageController.text = snapshot.child('edad').value.toString(); // Edad
        _genderController.text = snapshot.child('genero').value.toString(); // Género
        _locationController.text = snapshot.child('ubicacion').value.toString(); // Ubicación
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se encontró el usuario en la base de datos")),
      );
    }
  }

  // Guardar los datos modificados en Firebase
  void _saveUserData() async {
    String formattedEmail = formatEmail(widget.email);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$formattedEmail");

    Map<String, dynamic> updatedData = {};

    // Solo actualizamos los campos que han sido modificados
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

  // Eliminar cuenta
  void _deleteAccount() async {
    String formattedEmail = formatEmail(widget.email);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$formattedEmail");

    await ref.remove();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cuenta eliminada exitosamente")),
    );

    Navigator.pop(context); // Regresar a la pantalla anterior
  }

  // Alternar entre modo oscuro y claro
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
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
                // Campo de correo (solo lectura)
                TextField(
                  controller: _emailController,
                  enabled: false, // No editable
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
                // Campo de contraseña (solo lectura)
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  enabled: false, // No editable
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
                // Campo de nombre editable
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
                // Campo de edad editable
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
                // Campo de género editable
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
                // Campo de ubicación editable
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
                // Botón para guardar los cambios
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
                // Botón para eliminar la cuenta
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
    );
  }
}
