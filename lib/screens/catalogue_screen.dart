import 'package:flutter/material.dart';
import '../widgets/livre_card.dart'; // Importe ton widget LivreCard
import 'detail_screen.dart'; // Importe l'écran de détail

// Modèle de données Livre complet
class Livre {
  final String titre;
  final String auteur;
  final int annee;
  final Color couleur;
  final double note;
  final String genre;
  bool lu;
  bool favori;
  final bool nouveaute;

  Livre({
    required this.titre,
    required this.auteur,
    required this.annee,
    required this.couleur,
    required this.note,
    required this.genre,
    this.lu = false,
    this.favori = false,
    this.nouveaute = false,
  });
}

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  // Liste complète de livres pour le test
  final List<Livre> livres = [
    Livre(titre: 'Flutter pour les nuls', auteur: 'Jean Dupont', annee: 2021, couleur: Colors.blue, note: 4.5, genre: 'Informatique', nouveaute: true),
    Livre(titre: 'Apprendre Dart', auteur: 'Marie Curie', annee: 2019, couleur: Colors.green, note: 4.8, genre: 'Informatique', nouveaute: false),
    Livre(titre: 'Clean Code', auteur: 'Robert Martin', annee: 2008, couleur: Colors.orange, note: 4.9, genre: 'Informatique', nouveaute: true),
    Livre(titre: 'Design Patterns', auteur: 'Erich Gamma', annee: 1994, couleur: Colors.purple, note: 4.7, genre: 'Roman', nouveaute: false),
    Livre(titre: 'Refactoring', auteur: 'Martin Fowler', annee: 1999, couleur: Colors.red, note: 4.6, genre: 'Histoire', nouveaute: true),
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrage des livres qui sont des nouveautés pour la liste horizontale
    final livresNouveautes = livres.where((l) => l.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue des livres'),
      ),
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
          
          // ListView horizontal des nouveautés
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

          // Q4.4 & Q4.7 : ListView.builder vertical avec LivreCard et gestion du clic (Navigator.push)
          Expanded(
            child: ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreCard(
                  livre: livre,
                  onTap: () {
                    // Q4.7 : Navigation vers l'écran de détail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(livre: livre),
                      ),
                    ).then((_) {
                      // Rafraîchir l'état du catalogue au retour si un livre a été modifié
                      setState(() {});
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}