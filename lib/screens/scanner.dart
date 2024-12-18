import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:taller1/screens/home_screen.dart'; 
import 'package:taller1/screens/profileScreen.dart';

class QR extends StatefulWidget {
  const QR({super.key});

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  String? dataScanned;
  int _indice = 1; 
  String? promocion = '';  // Variable para mostrar la promoción si es válida.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código QR'),
        backgroundColor: const Color.fromARGB(255, 228, 24, 24),
      ),
      body: Column(
        children: [
          // Parte superior con el escáner QR
          Expanded(
            flex: 1,
            child: MobileScanner(
              onDetect: (BarcodeCapture barcodes) {
                final codigos = barcodes.barcodes;
                if (codigos.isNotEmpty && codigos.first.rawValue != null) {
                  setState(() {
                    dataScanned = codigos.first.rawValue!;
                    print("Código QR detectado: $dataScanned"); // Depuración

                    // Si el código contiene "promo", asignamos una promoción
                    if (dataScanned!.contains('promo')) {
                      promocion = '¡Promoción especial para ti! Obtén un 20% de descuento.';
                    } else {
                      promocion = ''; // No hay promoción si no se escanea un código válido
                    }
                  });
                } else {
                  print("No se detectó código QR"); // Depuración
                }
              },
            ),
          ),
          
          // Mostrar la promoción si existe
          if (promocion != null && promocion!.isNotEmpty) 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: const Color.fromARGB(255, 255, 233, 233),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_offer,
                        size: 40,
                        color: Color.fromARGB(255, 199, 16, 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        promocion!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 199, 16, 16),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          // Mostrar el QR escaneado si está presente
          Expanded(
            flex: 1,
            child: dataScanned == null
                ? const Center(child: Text('No hay código QR escaneado'))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dataScanned!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () {
                          // Aquí podrías agregar la lógica para abrir el sitio
                          print('Abrir sitio: $dataScanned');
                        },
                        child: const Text("Abrir sitio"),
                      ),
                    ],
                  ),
          ),
        ],
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
                builder: (context) => const ProfileScreen(email: 'usuario@correo.com'),
              ),
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
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
