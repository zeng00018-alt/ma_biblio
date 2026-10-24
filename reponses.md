# Réponses aux questions du TP - MaBiblio Flutter

## 0. Configuration et Environnement
* **Q0.8** : La configuration des actifs (`assets`) s'effectue dans le fichier `pubspec.yaml` sous la section `flutter:`, en déclarant explicitement le chemin du fichier de données (`- assets/livres.json`). Cela permet au framework d'embarquer le fichier JSON dans le bundle de l'application lors de la compilation.

## 1. Structure du Projet et Architecture
* **Q1.2** : L'architecture du projet repose sur une organisation modulaire par dossiers (`models/`, `screens/`, `services/`, `widgets/`) afin de séparer clairement les responsabilités (séparation des préoccupations / SoC) et de faciliter la maintenabilité du code.
* **Q1.4** : Un `StatelessWidget` est utilisé pour les composants statiques dont l'état ne change pas au cours du cycle de vie (ex: affichage d'une carte de livre fixe), tandis qu'un `StatefulWidget` est indispensable pour les écrans dynamiques nécessitant une mise à jour de l'interface utilisateur suite à une action (ex: basculer un livre en favori ou marquer comme lu).

## 2. Gestion des Listes (Catalogue)
* **Q2.1** : Pour afficher une collection dynamique d'éléments, on utilise le widget `ListView.builder` plutôt qu'une `ListView` classique, car il permet un rendu paresseux (*lazy loading*), n'instanciant en mémoire que les éléments visibles à l'écran, ce qui optimise les performances.
* **Q2.5** : Chaque élément de la liste est encapsulé dans une `Card` pour améliorer l'ergonomie visuelle, offrant une élévation et un espacement standardisés conformes aux directives Material Design.
* **Q2.8** : La gestion des interactions sur les lignes de la liste (comme le clic pour voir les détails ou modifier l'état) est assurée par des callbacks (`onTap`) transmis aux widgets enfants.

## 3. Vues en Grille (Galerie)
* **Q3.1** : L'affichage en galerie est réalisé à l'aide de `GridView.builder` associé à un `SliverGridDelegateWithFixedCrossAxisCount`, ce qui permet de définir un nombre fixe de colonnes (par exemple 2 colonnes) tout en gérant dynamiquement le nombre d'éléments.
* **Q3.2** : Les contraintes d'affichage dans la grille (rapports de largeur/hauteur ou `aspectRatio`) garantissent que les éléments visuels conservent un aspect proportionné et esthétique quelle que soit la taille de l'écran.

## 4. Composants et Design
* **Q4.3** : La personnalisation visuelle s'appuie sur l'utilisation du paramètre `ThemeData` global (avec Material 3 activé) et de propriétés locales comme les couleurs dynamiques converties depuis des codes hexadécimaux (`Color(int.parse(...))`).
* **Q4.5** : L'utilisation de composants réutilisables (widgets personnalisés) évite la duplication de code et garantit une cohérence graphique à travers les différents onglets de l'application.

## 5. Gestion de l'État et Interactions
* **Q5.2** : L'état local de l'application est géré via la méthode `setState()`, qui notifie le framework qu'une variable d'état a changé et qu'il faut reconstruire l'arbre des widgets concernés.
* **Q5.3** : La synchronisation entre les différents onglets est assurée en remontant l'état ou en passant des fonctions de callback de rafraîchissement (`onUpdate`) depuis le composant parent (`HomePage`).
* **Q5.6** : La modification d'un attribut d'un objet (ex: `livre.favori = !livre.favori`) déclenche à la fois la mise à jour de l'interface graphique et la sauvegarde automatique de la liste mise à jour vers le stockage persistant.

## 6. Navigation
* **Q6.3** : La navigation principale de l'application repose sur un `BottomNavigationBar` gérant un index actif (`_currentIndex`), permettant de basculer instantanément entre les trois écrans principaux : Catalogue, Galerie et Ma liste, tandis que les écrans secondaires (comme les Paramètres) utilisent la pile de navigation classique (`Navigator.push`).

## 7. Services, JSON et Persistance Locale
* **Q7.2** : Le service `LivreService` gère la récupération des données. Au premier lancement, il charge le fichier statique initial depuis les assets (`rootBundle.loadString('assets/livres.json')`).
* **Q7.4** : La persistance locale est assurée par le package `path_provider` pour récupérer le répertoire des documents de l'application, combiné à la manipulation de fichiers (`File`) pour lire et écrire une version modifiée des données au format JSON (`mabiblio.json`).
* **Q7.6** : Les méthodes de sérialisation `fromJson` (usine de construction) et `toJson` (conversion en Map) permettent de faire la passerelle bidirectionnelle entre les objets Dart du modèle `Livre` et les données textuelles au format JSON.

---

## Tableau Comparatif : Assets Statiques vs Stockage Persistant (`path_provider`)

| Critère de Comparaison | Fichiers Assets (`assets/livres.json`) | Stockage Persistant (`path_provider` / `mabiblio.json`) |
| :--- | :--- | :--- |
| **Emplacement** | Intégré dans le bundle/package de l'application. | Répertoire sécurisé et privé des documents de l'appareil. |
| **Mode d'accès** | **Lecture seule** (impossible de modifier ou d'écrire dedans après compilation). | **Lecture et Écriture** (permet d'ajouter, modifier ou supprimer des données dynamiquement). |
| **Persistance des modifications** | Les modifications sont perdues à chaque redémarrage de l'application. | Les modifications sont conservées de manière permanente sur l'appareil. |
| **Cas d'usage principal** | Fournir des données initiales par défaut ou des configurations de base. | Sauvegarder l'état utilisateur, les préférences et les données modifiées en temps réel. |

---

## Questions de Réflexion

1. **Quel est l'intérêt d'utiliser une architecture en couches (Models, Services, Screens) dans un projet Flutter ?**
   * *Réponse* : Elle garantit une séparation claire des responsabilités. Le modèle gère la structure des données, le service gère la logique métier et les accès aux sources de données (JSON/fichiers), et les écrans se concentrent uniquement sur l'affichage et l'interaction utilisateur. Cela rend le code plus propre, testable, évolutif et facile à déboguer.

2. **Comment l'application gère-t-elle la transition entre les données par défaut et les données modifiées par l'utilisateur ?**
   * *Réponse* : Au démarrage, le service vérifie si un fichier de sauvegarde existe dans le répertoire local de l'appareil (`path_provider`). S'il existe, il le charge en priorité (permettant de retrouver les modifications de l'utilisateur). S'il n'existe pas (premier lancement), il charge le fichier initial des assets, le sauvegarde localement, puis utilise cette copie pour les sessions futures.