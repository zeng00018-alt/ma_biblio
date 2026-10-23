import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Column(
        children: [
          // Q1.1 & Q1.2 : Mon profil
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Q1.2 : SnackBar au clic
              // Visuellement : Effet d'encre (InkWell) si onTap est défini. 
              // Si on supprime onTap, l'effet visuel disparaît et le widget devient non interactif.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),

          // Q1.3 & Q1.5 : Notifications personnalisé
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

          // Q1.3 : Langue
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),

          // Q1.3 & Q1.4 : À propos (Test des propriétés)
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos'),
            subtitle: Text('Informations sur l\'application...\nVersion 1.0.0'),
            // Q1.4 :
            // dense: true -> Réduit la hauteur verticale et la taille de police du ListTile
            // isThreeLine: true -> Permet d'afficher un sous-titre sur 2 lignes (ou plus)
            // enabled: false -> Grise le ListTile et désactive les interactions (onTap)
            dense: false,
            isThreeLine: true,
            enabled: true,
          ),
        ],
      ),
    );
  }
}