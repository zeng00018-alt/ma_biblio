import 'package:flutter/material.dart';
import 'screens/parametres_screen.dart';
import 'screens/catalogue_screen.dart'; // Assure-toi que le chemin correspond
import 'services/livre_service.dart';
import 'models/livre.dart'; // Si ton modèle Livre est dans un fichier séparé models/livre.dart

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Livre>> _futurLivres;

  @override
  void initState() {
    super.initState();
    // Q7.5 : Chargement des livres au démarrage
    _futurLivres = LivreService.chargerLivres();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _futurLivres,
      builder: (context, snapshot) {
        // Pendant le chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Ma Bibliothèque')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        // En cas d'erreur
        else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Ma Bibliothèque')),
            body: Center(
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        // Une fois les données reçues
        else {
          final livres = snapshot.data ?? [];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Ma Bibliothèque - TP'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ParametresScreen(),
                      ),
                    ).then((_) {
                      // Recharger si on revient des paramètres (ex: réinitialisation)
                      setState(() {
                        _futurLivres = LivreService.chargerLivres();
                      });
                    });
                  },
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Catalogue chargé depuis le JSON (${livres.length} livres) :',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                // Affichage de la liste des livres chargés depuis le JSON
                Expanded(
                  child: ListView.builder(
                    itemCount: livres.length,
                    itemBuilder: (context, index) {
                      final livre = livres[index];
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
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}