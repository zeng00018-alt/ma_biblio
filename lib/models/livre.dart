import 'package:flutter/material.dart';

class Livre {
  final int id;
  final String titre;
  final String auteur;
  final String genre;
  final int annee;
  final double note;
  final Color couleur;
  final bool nouveaute;
  bool lu;
  bool favori;

  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.genre,
    required this.annee,
    required this.note,
    required this.couleur,
    this.nouveaute = false,
    this.lu = false,
    this.favori = false,
  });

  // Q7.3 : Constructeur factory Livre.fromJson
  factory Livre.fromJson(Map<String, dynamic> json) {
    String hexColor = json['couleur'] ?? '#9E9E9E';
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    Color parsedColor = Color(int.parse(hexColor, radix: 16));

    return Livre(
      id: json['id'] ?? 0,
      titre: json['titre'] ?? '',
      auteur: json['auteur'] ?? '',
      genre: json['genre'] ?? '',
      annee: json['annee'] ?? 2000,
      note: (json['note'] as num?)?.toDouble() ?? 0.0,
      couleur: parsedColor,
      nouveaute: json['nouveaute'] ?? false,
      lu: json['lu'] ?? false,
      favori: json['favori'] ?? false,
    );
  }

  // Q7.3 : Méthode toJson pour la sauvegarde
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'auteur': auteur,
      'genre': genre,
      'annee': annee,
      'note': note,
      'couleur': '#${couleur.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
      'nouveaute': nouveaute,
      'lu': lu,
      'favori': favori,
    };
  }
}