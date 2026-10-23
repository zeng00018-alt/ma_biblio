import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Liste de nos éléments de paramètres
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
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      // Q2.2 : Remplacement de Column par ListView avec un padding de 8
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        // Q2.3 : Utilisation de ListTile.divideTiles pour insérer les séparateurs proprement
        children: ListTile.divideTiles(
          context: context,
          tiles: parametresTiles,
        ).toList(),
      ),
    );
  }
}