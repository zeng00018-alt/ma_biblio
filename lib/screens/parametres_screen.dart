import 'package:flutter/material.dart';
import '../services/livre_service.dart'; // N'oublie pas l'import du service

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Liste de nos éléments de paramètres (le bouton de réinitialisation est inclus dedans)
    final List<Widget> parametresTiles = [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mon profil'),
        subtitle: const Text('Nom, e-mail, mot de passe'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil sélectionné')),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text('Notifications'),
        tileColor: Colors.grey[200],
        iconColor: Colors.deepPurple,
        textColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {},
      ),
      const ListTile(
        leading: Icon(Icons.language),
        title: Text('Langue'),
        subtitle: Text('Français'),
      ),
      const ListTile(
        leading: Icon(Icons.info),
        title: Text('À propos'),
        subtitle: Text('Informations sur l\'application...\nVersion 1.0.0'),
        dense: false,
        isThreeLine: true,
        enabled: true,
      ),
      // Q7.10 : Réinitialisation de la bibliothèque
      ListTile(
        leading: const Icon(Icons.restart_alt, color: Colors.red),
        title: const Text('Réinitialiser ma bibliothèque', style: TextStyle(color: Colors.red)),
        subtitle: const Text('Effacer les modifications et restaurer les données d\'origine'),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirmation'),
                content: const Text('Voulez-vous vraiment réinitialiser toute votre bibliothèque ? Vos choix (favoris, lus) seront perdus.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop(); // Fermer la boîte de dialogue
                      await LivreService.reinitialiserBibliotheque();
                      
                      // Fermer l'écran des paramètres pour revenir à l'accueil 
                      // (le .then() dans main.dart rafraîchira automatiquement les données)
                      Navigator.of(context).pop(); 

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bibliothèque réinitialisée avec succès')),
                      );
                    },
                    child: const Text('Réinitialiser', style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: ListTile.divideTiles(
          context: context,
          tiles: parametresTiles,
        ).toList(),
      ),
    );
  }
}