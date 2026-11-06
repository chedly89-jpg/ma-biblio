import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../widgets/livre_tile.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Nouveautés',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Liste horizontale des nouveautés.
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, index) {
                final livre = nouveautes[index];

                return Container(
                  width: 110,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: livre.couleur,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // ListView.builder construit les éléments à la demande.
          // Pour 1 000 livres, il évite de créer toutes les lignes
          // immédiatement, ce qui économise des ressources.
          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 72);
              },
            ),
          ),
        ],
      ),
    );
  }
}
