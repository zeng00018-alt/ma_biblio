import 'package:flutter/material.dart';

// Modèle Livre (ou importe-le depuis ton fichier de catalogue)
class Livre {
  final String titre;
  final String auteur;
  final Color couleur;

  Livre({
    required this.titre,
    required this.auteur,
    required this.couleur,
  });
}

class GalerieScreen extends StatelessWidget {
  GalerieScreen({Key? key}) : super(key: key);

  // Liste de livres pour alimenter la grille (Q5.5)
  final List<Livre> livres = [
    Livre(titre: 'Flutter pour les nuls', auteur: 'Jean Dupont', couleur: Colors.blue),
    Livre(titre: 'Apprendre Dart', auteur: 'Marie Curie', couleur: Colors.green),
    Livre(titre: 'Clean Code', auteur: 'Robert Martin', couleur: Colors.orange),
    Livre(titre: 'Design Patterns', auteur: 'Erich Gamma', couleur: Colors.purple),
    Livre(titre: 'Refactoring', auteur: 'Martin Fowler', couleur: Colors.red),
    Livre(titre: 'Algorithmique Avancée', auteur: 'Al-Khwarismi', couleur: Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie des livres'),
      ),
      // Q5.6 : Utilisation de GridView.extent pour une grille adaptative (max 150 px de large par case)
      body: GridView.extent(
        maxCrossAxisExtent: 150, // Q5.6
        padding: const EdgeInsets.all(10), // Q5.2
        mainAxisSpacing: 10, // Q5.2
        crossAxisSpacing: 10, // Q5.2
        childAspectRatio: 0.7, // Q5.3 : Format couverture de livre
        children: livres.map((livre) {
          return Card(
            color: livre.couleur,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Q5.5 : Coins arrondis
            ),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // Q5.5 : Column centrée
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    maxLines: 2, // Q5.5 : 2 lignes max
                    overflow: TextOverflow.ellipsis, // Q5.5 : points de suspension si trop long
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    livre.auteur,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}