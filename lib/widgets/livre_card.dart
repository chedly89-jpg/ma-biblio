import 'package:flutter/material.dart';

import '../models/livre.dart';
import 'livre_tile.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shadowColor: Colors.indigo,
      surfaceTintColor: Colors.indigo,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(onTap: onTap, child: livreTile(livre)),
    );
  }
}
