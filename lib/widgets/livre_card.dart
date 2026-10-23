import 'package:flutter/material.dart';
import '../screens/catalogue_screen.dart'; // Ajuste l'import selon ton arborescence pour accéder à la classe Livre

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap; // Q4.5 : Pour gérer le clic vers le détail

  const LivreCard({Key? key, required this.livre, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Q4.2 & Q4.3 : Propriétés de la carte
      elevation: 4,
      shadowColor: Colors.black26,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // Q4.5 : clipBehavior indispensable pour que l'InkWell respecte les coins arrondis
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap, // Q4.5 : Clic sur la carte
        child: ListTile(
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
        ),
      ),
    );
  }
}