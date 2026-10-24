import 'package:flutter/material.dart';
import 'services/livre_service.dart';
import 'models/livre.dart'; // <-- Ton vrai modèle de référence

// On cache 'Livre' de ces imports pour éviter le conflit d'ambiguïté
import 'screens/catalogue_screen.dart' hide Livre;
import 'screens/galerie_screen.dart';
import 'screens/ma_liste_screen.dart' hide Livre;
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MonApplicationTp());
}

class MonApplicationTp extends StatelessWidget {
  const MonApplicationTp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio TP Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
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
  int _currentIndex = 0; // Q8.1 : Index de l'onglet actif

  @override
  void initState() {
    super.initState();
    _chargerDonnees();
  }

  void _chargerDonnees() {
    setState(() {
      _futurLivres = LivreService.chargerLivres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Livre>>(
      future: _futurLivres,
      builder: (context, snapshot) {
        // Pendant le chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('MaBiblio')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        // En cas d'erreur
        else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('MaBiblio')),
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
          // Q8.2 : Liste des écrans de l'application
          // Note : On appelle les constructeurs standards de tes écrans
          final List<Widget> _ecrans = [
            const CatalogueScreen(),
            const GalerieScreen(),
            const MaListeScreen(),
          ];

          return Scaffold(
            appBar: AppBar(
              title: const Text('MaBiblio - TP Flutter'),
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
                      // Recharge les données au retour des paramètres (ex: réinitialisation)
                      _chargerDonnees();
                    });
                  },
                ),
              ],
            ),
            // Q8.2 : Affichage de l'écran actif
            body: _ecrans[_currentIndex],
            // Q8.1 : BottomNavigationBar à trois onglets
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Catalogue',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_on),
                  label: 'Galerie',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.checklist),
                  label: 'Ma liste',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}