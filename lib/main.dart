import 'package:flutter/material.dart';
import 'screens/parametres_screen.dart'; // Assure-toi que le chemin correspond à ton arborescence

void main() {
  runApp(const MonApplicationTp());
}

class MonApplicationTp extends StatelessWidget {
  const MonApplicationTp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Modèle de données Livre (à adapter si tu l'as déjà créé ailleurs)
class Livre {
  String titre;
  String auteur;
  int annee;
  Color couleur;
  double note;

  Livre({
    required this.titre,
    required this.auteur,
    required this.annee,
    required this.couleur,
    required this.note,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Fonction livreTile demandée à la Q1.7
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
    // Liste temporaire des 3 premiers livres pour tester (Q1.7)
    final List<Livre> livres = [
      Livre(titre: 'Flutter pour les nuls', auteur: 'Jean Dupont', annee: 2021, couleur: Colors.blue, note: 4.5),
      Livre(titre: 'Apprendre Dart', auteur: 'Marie Curie', annee: 2019, couleur: Colors.green, note: 4.8),
      Livre(titre: 'Clean Code', auteur: 'Robert Martin', annee: 2008, couleur: Colors.orange, note: 4.9),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Bibliothèque - TP'),
        actions: [
          // Q1.6 : Bouton d'accès aux paramètres
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Mes 3 premiers livres (Test Q1.7) :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Affichage des 3 premiers livres via la fonction livreTile
          ...livres.map((livre) => livreTile(livre)).toList(),
        ],
      ),
    );
  }
}