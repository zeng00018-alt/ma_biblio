import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/livre.dart';

class LivreService {
  // Nom du fichier local pour la sauvegarde
  static const String _localFileName = 'mabiblio.json';

  // Obtenir le fichier local dans le dossier des documents de l'application
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_localFileName');
  }

  // Q7.4 & Q7.8 : Charger les livres (depuis le fichier local s'il existe, sinon depuis les assets)
  static Future<List<Livre>> chargerLivres() async {
    try {
      final file = await _getLocalFile();
      
      String jsonString;
      // Q7.8 : Si le fichier de sauvegarde existe, on le lit en priorité
      if (await file.exists()) {
        jsonString = await file.readAsString();
      } else {
        // Sinon, on lit le fichier JSON initial dans les assets
        jsonString = await rootBundle.loadString('assets/livres.json');
      }

      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Livre.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des livres : $e');
    }
  }

  // Q7.7 : Sauvegarder les livres dans le fichier local
  static Future<void> sauvegarderLivres(List<Livre> livres) async {
    try {
      final file = await _getLocalFile();
      final jsonList = livres.map((l) => l.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      throw Exception('Erreur lors de la sauvegarde : $e');
    }
  }

  // Q7.10 : Réinitialiser la bibliothèque en supprimant le fichier local
  static Future<void> reinitialiserBibliotheque() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Erreur lors de la réinitialisation : $e');
    }
  }
}