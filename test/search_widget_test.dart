import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:japanese_dict/screens/search_screen.dart';

void main() {
  testWidgets('Testing SearchBar to see if it is empty when app starts', (
    testor,
  ) async {
    await testor.pumpWidget(const MaterialApp(home: SearchScreen()));

    final search_bar_text = find.byType(TextField);
    expect(search_bar_text, findsOneWidget);

    final textfield_controller = testor.widget<TextField>(search_bar_text);

    final controller = textfield_controller.controller;
    expect(controller?.text ?? '', '');

    await testor.enterText(search_bar_text, 'dog');
    await testor.pump();

    expect(find.text('dog'), findsOneWidget);
  });
}
