import 'package:flutter/material.dart';

import '../models/livre.dart';

Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(livre.titre[0], style: const TextStyle(color: Colors.white)),
    ),
    title: Text(livre.titre),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (livre.favori)
          const Icon(Icons.favorite, color: Colors.red, size: 18),
        if (livre.lu)
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
        const SizedBox(width: 4),
        Text('${livre.note}'),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.amber, size: 18),
      ],
    ),
  );
}
