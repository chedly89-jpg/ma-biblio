import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../widgets/livre_card.dart';
import '../widgets/livre_grid_item.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;

  const GalerieScreen({super.key, required this.livres});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _modeGrille = true;

  void _ouvrirDetail(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(livre: livre, livres: widget.livres),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final livres = widget.livres;
    final largeur = MediaQuery.of(context).size.width;
    final colonnes = largeur < 600 ? 2 : (largeur < 900 ? 3 : 4);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() => livres.sort((a, b) => b.note.compareTo(a.note)));
            },
          ),
          IconButton(
            icon: Icon(_modeGrille ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() => _modeGrille = !_modeGrille);
            },
          ),
        ],
      ),
      body: _modeGrille
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: livres.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colonnes,
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreGridItem(
                  livre: livre,
                  onTap: () => _ouvrirDetail(livre),
                );
              },
            )
          : ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreCard(
                  livre: livre,
                  onTap: () => _ouvrirDetail(livre),
                );
              },
            ),
    );
  }
}
