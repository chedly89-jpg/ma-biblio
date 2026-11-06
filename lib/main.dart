import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'screens/catalogue_screen.dart';
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart';
import 'screens/parametres_screen.dart';
import 'services/livre_service.dart';

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
  late Future<List<Livre>> _futurLivres;

  @override
  void initState() {
    super.initState();
    _futurLivres = chargerLivres();
  }

  void _recharger() {
    setState(() {
      _futurLivres = chargerLivres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _futurLivres,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final livres = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('MaBiblio'),
            actions: [
              IconButton(
                icon: const Icon(Icons.checklist),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaListeScreen(livres: livres),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalerieScreen(livres: livres),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ParametresScreen(onReinitialiser: _recharger),
                    ),
                  );
                },
              ),
            ],
          ),
          body: CatalogueScreen(livres: livres),
        );
      },
    );
  }
}
