import 'package:flutter/material.dart';

// Modèle de données Livre adapté pour la partie 3
class Livre {
  final String titre;
  final String auteur;
  final int annee;
  final Color couleur;
  final double note;
  final String genre;
  bool lu;
  final bool nouveaute;

  Livre({
    required this.titre,
    required this.auteur,
    required this.annee,
    required this.couleur,
    required this.note,
    required this.genre,
    this.lu = false,
    this.nouveaute = false,
  });
}

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({Key? key}) : super(key: key);

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  // Q3.2 : Variable pour le filtre nouveautés
  bool _nouveautesSeulement = false;

  // Q3.3 : Map des 5 genres (tous à true au départ)
  final Map<String, bool> _genres = {
    'Informatique': true,
    'Science': true,
    'Roman': true,
    'Histoire': true,
    'Arts': true,
  };

  // Liste de livres d'exemple pour tester les filtres et les "lus"
  final List<Livre> _livres = [
    Livre(titre: 'Flutter Avancé', auteur: 'Alice', annee: 2022, couleur: Colors.blue, note: 4.8, genre: 'Informatique', lu: false, nouveaute: true),
    Livre(titre: 'Physique Quantique', auteur: 'Bob', annee: 2020, couleur: Colors.purple, note: 4.9, genre: 'Science', lu: true, nouveaute: false),
    Livre(titre: 'Les Misérables', auteur: 'Victor Hugo', annee: 1862, couleur: Colors.red, note: 4.7, genre: 'Roman', lu: false, nouveaute: false),
    Livre(titre: 'Seconde Guerre', auteur: 'Charles', annee: 2015, couleur: Colors.orange, note: 4.5, genre: 'Histoire', lu: true, nouveaute: true),
    Livre(titre: 'Peinture Moderne', auteur: 'David', annee: 2018, couleur: Colors.green, note: 4.2, genre: 'Arts', lu: false, nouveaute: false),
  ];

  // Fonction utilitaire pour associer une icône à chaque genre (Q3.4)
  IconData _getGenreIcon(String genre) {
    switch (genre) {
      case 'Informatique':
        return Icons.computer;
      case 'Science':
        return Icons.science;
      case 'Roman':
        return Icons.book;
      case 'Histoire':
        return Icons.history;
      case 'Arts':
        return Icons.palette;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrage des livres selon les genres cochés et le filtre nouveauté
    final livresFiltres = _livres.where((livre) {
      if (_nouveautesSeulement && !livre.nouveaute) return false;
      final genreActif = _genres[livre.genre] ?? false;
      if (!genreActif) return false;
      return true;
    }).toList();

    // Q3.8 : Calcul dynamique de X (lus) et Y (affichés)
    final int y = livresFiltres.length;
    final int x = livresFiltres.where((l) => l.lu).length;

    // Q3.6 : Gestion de l'état tristate pour "Tous les genres"
    bool? tousGenresValue;
    final allTrue = _genres.values.every((v) => v);
    final allFalse = _genres.values.every((v) => !v);
    if (allTrue) {
      tousGenresValue = true;
    } else if (allFalse) {
      tousGenresValue = false;
    } else {
      tousGenresValue = null; // État indéterminé (tiret)
    }

    return Scaffold(
      appBar: AppBar(
        // Q3.8 : Affichage dynamique « Lus : X / Y »
        title: Text('Lus : $x / $y'),
      ),
      body: ListView(
        children: [
          // Q3.2 : CheckboxListTile Nouveautés
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            onChanged: (bool? value) {
              setState(() {
                _nouveautesSeulement = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const Divider(),

          // Q3.6 : CheckboxListTile "Tous les genres" avec tristate
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: tousGenresValue,
            activeColor: Colors.blueAccent,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              setState(() {
                // Si l'utilisateur clique alors qu'on est en état mixte (null) ou faux, on coche tout. Sinon on décoche tout.
                final targetState = value ?? true;
                _genres.updateAll((key, val) => targetState);
              });
            },
          ),
          const Divider(),

          // Q3.3, Q3.4 & Q3.5 : Génération dynamique des CheckboxListTile par genre
          ..._genres.keys.map((genre) {
            final count = _livres.where((l) => l.genre == genre).length;

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$count livres'),
              secondary: Icon(_getGenreIcon(genre)), // Q3.4
              activeColor: Colors.deepPurple, // Q3.4
              value: _genres[genre],
              controlAffinity: ListTileControlAffinity.leading, // Q3.5 : Place la case à gauche
              onChanged: (bool? value) {
                setState(() {
                  _genres[genre] = value ?? false;
                });
              },
            );
          }).toList(),

          const Divider(thickness: 2),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Catalogue filtré',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // Q3.7 : Liste des livres filtrés avec CheckboxListTile et titre barré si lu
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: livresFiltres.length,
            separatorBuilder: (context, index) => const Divider(indent: 72),
            itemBuilder: (context, index) {
              final livre = livresFiltres[index];
              return CheckboxListTile(
                title: Text(
                  livre.titre,
                  style: TextStyle(
                    // Q3.7 : Titre barré si le livre est lu
                    decoration: livre.lu
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text('${livre.auteur} – ${livre.genre}'),
                secondary: CircleAvatar(
                  backgroundColor: livre.couleur,
                  child: Text(
                    livre.titre.isNotEmpty ? livre.titre[0] : '?',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                value: livre.lu,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    livre.lu = value ?? false;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}