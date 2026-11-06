import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: Column(
        children: [
          // Q1.1 + Q1.2 : Mon profil avec onTap et SnackBar
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),

          // Q1.3 + Q1.5 : Notifications personnalisé
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            tileColor: Colors.indigo.shade50,
            iconColor: Colors.indigo,
            textColor: Colors.indigo.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // Q1.3 : Langue
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),

          // Q1.3 + Q1.4 : À propos
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos'),
            subtitle: Text('MaBiblio version 1.0\nTP Listes et grilles'),
            // Q1.4 : tester successivement (une à la fois) :
            // dense: true,        // lignes plus compactes (hauteur et texte réduits)
            // isThreeLine: true,  // réserve de la place pour un subtitle sur 2 lignes
            // enabled: false,     // tuile grisée, plus de réaction au clic
          ),
        ],
      ),
    );
  }
}
