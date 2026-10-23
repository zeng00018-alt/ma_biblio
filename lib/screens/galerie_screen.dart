import 'package:flutter/material.dart';
import 'catalogue_screen.dart'; // Pour le modèle Livre et DetailScreen
import '../widgets/livre_grid_item.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  const GalerieScreen({Key? key}) : super(key: key);

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  // Liste de livres d'exemple
  final List<Livre> livres = [
    Livre(titre: 'Flutter pour les nuls', auteur: 'Jean Dupont', annee: 2021, couleur: Colors.blue, note: 4.5, genre: 'Informatique', favori: true, nouveaute: true),
    Livre(titre: 'Apprendre Dart', auteur: 'Marie Curie', annee: 2019, couleur: Colors.green, note: 4.8, genre: 'Informatique', favori: false, nouveaute: false),
    Livre(titre: 'Clean Code', auteur: 'Robert Martin', annee: 2008, couleur: Colors.orange, note: 4.9, genre: 'Informatique', favori: true, nouveaute: true),
    Livre(titre: 'Design Patterns', auteur: 'Erich Gamma', annee: 1994, couleur: Colors.purple, note: 4.7, genre: 'Roman', favori: false, nouveaute: false),
    Livre(titre: 'Refactoring', auteur: 'Martin Fowler', annee: 1999, couleur: Colors.red, note: 4.6, genre: 'Histoire', favori: false, nouveaute: true),
    Livre(titre: 'Algorithmique', auteur: 'Al-Khwarismi', annee: 820, couleur: Colors.teal, note: 4.95, genre: 'Science', favori: true, nouveaute: false),
  ];

  // Q6.6 : État pour basculer entre vue grille (true) et vue liste (false)
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    // Q6.4 : Calcul responsive du nombre de colonnes selon la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 2; // Moins de 600 px -> 2 colonnes
    } else if (screenWidth < 900) {
      crossAxisCount = 3; // Entre 600 et 900 px -> 3 colonnes
    } else {
      crossAxisCount = 4; // Au-delà de 900 px -> 4 colonnes
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie & Catalogue'),
        actions: [
          // Q6.7 : Bouton de tri par note décroissante
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Trier par note décroissante',
            onPressed: () {
              setState(() {
                livres.sort((a, b) => b.note.compareTo(a.note));
              });
            },
          ),
          // Q6.6 : Bouton de bascule entre Grille et Liste
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: 'Changer d\'affichage',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      // Q6.6 : Affichage conditionnel Grille vs Liste
      body: _isGridView
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: livres.length,
              // Q6.1 & Q6.3 : SliverGridDelegate (peut aussi utiliser SliverGridDelegateWithMaxCrossAxisExtent si souhaité en Q6.3)
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Q6.4 : Responsive dynamique
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreGridItem(
                  livre: livre,
                  onTap: () {
                    // Q6.5 : Ouvrir le DetailScreen au clic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    ).then((_) {
                      setState(() {}); // Rafraîchir au retour
                    });
                  },
                );
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreCard(
                  livre: livre,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                );
              },
            ),
    );
  }
}