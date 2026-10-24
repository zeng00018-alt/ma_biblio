import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ma_biblio/main.dart';

void main() {
  testWidgets('MaBiblio smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MonApplicationTp());

    // Vérifie que le titre de l'application est présent
    expect(find.text('MaBiblio - TP Flutter'), findsOneWidget);
  });
}