import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/livre.dart';

Future<File> _fichierLocal() async {
  final dossier = await getApplicationDocumentsDirectory();
  return File('${dossier.path}/mabiblio.json');
}

Future<List<Livre>> chargerLivres() async {
  final fichier = await _fichierLocal();
  final String contenu;
  if (await fichier.exists()) {
    contenu = await fichier.readAsString();
  } else {
    contenu = await rootBundle.loadString('assets/livres.json');
  }
  final List<dynamic> donnees = jsonDecode(contenu);
  return donnees.map((e) => Livre.fromJson(e as Map<String, dynamic>)).toList();
}

Future<void> sauvegarderLivres(List<Livre> livres) async {
  final fichier = await _fichierLocal();
  final texte = jsonEncode(livres.map((l) => l.toJson()).toList());
  await fichier.writeAsString(texte);
}

Future<void> reinitialiserLivres() async {
  final fichier = await _fichierLocal();
  if (await fichier.exists()) {
    await fichier.delete();
  }
}
