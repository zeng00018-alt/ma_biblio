import 'package:flutter/material.dart';
import 'catalogue_screen.dart'; // Pour accéder au modèle Livre

class DetailScreen extends StatefulWidget {
  final Livre livre;

  const DetailScreen({Key? key, required this.livre}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livre.titre),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Q4.6 : Container en haut de 200 px avec la couleur du livre et le titre
                  Container(
                    height: 200,
                    color: widget.livre.couleur,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.livre.titre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // Q4.6 : Les trois ListTile d'informations
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Auteur'),
                    subtitle: Text(widget.livre.auteur),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Année'),
                    subtitle: Text('${widget.livre.annee}'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text('Genre'),
                    subtitle: Text(widget.livre.genre),
                  ),
                  const Divider(height: 1),

                  // Q4.6 & Q4.8 : OverflowBar avec les boutons d'action
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: OverflowBar(
                      spacing: 8.0,
                      alignment: MainAxisAlignment.end,
                      children: [
                        // Bouton Favori (Q4.8 : Stateful pour changer l'icône et l'état)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              widget.livre.favori = !widget.livre.favori;
                            });
                          },
                          icon: Icon(
                            widget.livre.favori
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          label: Text(
                            widget.livre.favori
                                ? 'Dans les favoris'
                                : 'Ajouter aux favoris',
                          ),
                        ),
                        // Bouton Marquer comme lu
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              widget.livre.lu = !widget.livre.lu;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.livre.lu
                                      ? 'Marqué comme lu'
                                      : 'Marqué comme non lu',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: Icon(
                            widget.livre.lu ? Icons.check_circle : Icons.circle_outlined,
                          ),
                          label: Text(
                            widget.livre.lu ? 'Lu' : 'Marquer comme lu',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}