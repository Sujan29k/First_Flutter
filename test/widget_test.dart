import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/main.dart';

void main() {
  group('Todo App Tests', () {
    testWidgets('Todo app has title and input field', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const TodoApp());

      // Verify that the app title is displayed
      expect(find.text('Enhanced Todo App'), findsWidgets);

      // Verify that input field is present
      expect(find.byType(TextField), findsOneWidget);

      // Verify that Add button is present
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('Can add a todo item', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const TodoApp());

      // Enter text into the text field
      await tester.enterText(find.byType(TextField), 'Test todo item');

      // Tap the Add button
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Verify that the todo item appears in the list
      expect(find.text('Test todo item'), findsOneWidget);

      // Verify that there's a checkbox for the new item
      expect(find.byType(Checkbox), findsOneWidget);

      // Verify that there's a delete button for the new item
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('Can toggle todo completion status', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const TodoApp());

      // Add a todo item
      await tester.enterText(find.byType(TextField), 'Test todo item');
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Find the checkbox and verify it's unchecked
      final checkbox = find.byType(Checkbox);
      expect(tester.widget<Checkbox>(checkbox).value, false);

      // Tap the checkbox to mark as completed
      await tester.tap(checkbox);
      await tester.pump();

      // Verify the checkbox is now checked
      expect(tester.widget<Checkbox>(checkbox).value, true);
    });

    testWidgets('Can delete a todo item', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const TodoApp());

      // Add a todo item
      await tester.enterText(find.byType(TextField), 'Test todo item');
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Verify the item exists
      expect(find.text('Test todo item'), findsOneWidget);

      // Tap the delete button
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      // Verify the item is deleted
      expect(find.text('Test todo item'), findsNothing);
    });

    testWidgets('Text field clears after adding todo', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const TodoApp());

      // Enter text into the text field
      await tester.enterText(find.byType(TextField), 'Test todo item');

      // Tap the Add button
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Verify that the text field is cleared
      expect(find.text('Test todo item'), findsOneWidget); // In the list
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });
  });
}
