import 'package:flutter/material.dart';

import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';
import 'screens/parametres_screen.dart';

void main() => runApp(const MaBiblioApp());

class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MaListeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.grid_on),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GalerieScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const CatalogueScreen(),
    );
  }
}
