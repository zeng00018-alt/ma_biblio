import 'package:flutter/material.dart';

// Modèle Livre mis à jour avec la propriété 'nouveaute'
class Livre {
  final String titre;
  final String auteur;
  final int annee;
  final Color couleur;
  final double note;
  final bool nouveaute;

  Livre({
    required this.titre,
    required this.auteur,
    required this.annee,
    required this.couleur,
    required this.note,
    this.nouveaute = false,
  });
}

class CatalogueScreen extends StatelessWidget {
  CatalogueScreen({Key? key}) : super(key: key);

  // Liste complète de livres pour le test
  final List<Livre> livres = [
    Livre(titre: 'Flutter pour les nuls', auteur: 'Jean Dupont', annee: 2021, couleur: Colors.blue, note: 4.5, nouveaute: true),
    Livre(titre: 'Apprendre Dart', auteur: 'Marie Curie', annee: 2019, couleur: Colors.green, note: 4.8, nouveaute: false),
    Livre(titre: 'Clean Code', auteur: 'Robert Martin', annee: 2008, couleur: Colors.orange, note: 4.9, nouveaute: true),
    Livre(titre: 'Design Patterns', auteur: 'Erich Gamma', annee: 1994, couleur: Colors.purple, note: 4.7, nouveaute: false),
    Livre(titre: 'Refactoring', auteur: 'Martin Fowler', annee: 1999, couleur: Colors.red, note: 4.6, nouveaute: true),
  ];

  // Fonction livreTile (Q1.7 réutilisée)
  Widget livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre.isNotEmpty ? livre.titre[0] : '?',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(livre.titre),
      subtitle: Text('${livre.auteur} – ${livre.annee}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${livre.note}'),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Q2.7 : Filtrer les livres qui sont des nouveautés
    final livresNouveautes = livres.where((l) => l.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue des livres'),
      ),
      // Q2.8 : Organisation avec une Column
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Nouveautés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Q2.7 & Q2.8 : ListView horizontal de 160 px de haut dans un SizedBox
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: livresNouveautes.length,
              itemBuilder: (context, index) {
                final livre = livresNouveautes[index];
                return Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: livre.couleur,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      livre.titre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Q2.6, Q2.8 : ListView.separated vertical dans un Expanded pour éviter l'erreur de contrainte
          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              separatorBuilder: (context, index) => const Divider(
                indent: 72, // Q2.6 : Divider indenté pour s'aligner après le leading
              ),
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}