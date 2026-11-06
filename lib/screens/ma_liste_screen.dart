import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../services/livre_service.dart';

class MaListeScreen extends StatefulWidget {
  final List<Livre> livres;

  const MaListeScreen({super.key, required this.livres});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  final Map<String, IconData> _icones = {
    'Roman': Icons.auto_stories,
    'Science': Icons.science,
    'Histoire': Icons.account_balance,
    'Jeunesse': Icons.child_care,
    'Informatique': Icons.computer,
  };

  bool? get _tousLesGenres {
    final valeurs = _genres.values;
    if (valeurs.every((v) => v)) return true;
    if (valeurs.every((v) => !v)) return false;
    return null;
  }

  List<Livre> get _livresFiltres {
    return widget.livres.where((l) {
      if (_genres[l.genre] != true) return false;
      if (_nouveautesSeulement && !l.nouveaute) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final affiches = _livresFiltres;
    final lus = affiches.where((l) => l.lu).length;

    return Scaffold(
      appBar: AppBar(title: Text('Lus : $lus / ${affiches.length}')),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (valeur) {
              setState(() => _nouveautesSeulement = valeur ?? false);
            },
          ),
          const Divider(),
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: _tousLesGenres,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (valeur) {
              setState(() {
                final nouvelleValeur = _tousLesGenres != true;
                _genres.updateAll((genre, ancienne) => nouvelleValeur);
              });
            },
          ),
          ..._genres.keys.map((genre) {
            final nombre = widget.livres.where((l) => l.genre == genre).length;
            return CheckboxListTile(
              secondary: Icon(_icones[genre]),
              title: Text(genre),
              subtitle: Text('$nombre livres'),
              activeColor: Colors.indigo,
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (valeur) {
                setState(() => _genres[genre] = valeur ?? false);
              },
            );
          }),
          const Divider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: affiches.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final livre = affiches[index];
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  livre.titre,
                  style: TextStyle(
                    decoration: livre.lu ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(livre.auteur),
                value: livre.lu,
                onChanged: (valeur) {
                  setState(() => livre.lu = valeur ?? false);
                  sauvegarderLivres(widget.livres);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
