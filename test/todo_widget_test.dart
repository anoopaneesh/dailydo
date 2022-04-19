import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/helpers/home_helper.dart';
import 'package:todo_app/widgets/todo.dart';
import 'mock_data.dart';

Widget createWidgetForTesting({required Widget child}) {
  return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(home: Scaffold(body: child)));
}

@GenerateMocks([HomeHelper, BuildContext])
void main() {
  group('TodoWidget Test', () {
    testWidgets('Test todo title and description', (WidgetTester tester) async {
      final tapCompleter = Completer<void>();
      final checkCompleter = Completer<bool?>();
      final todo = MockData.mockTodosData[0];
      await tester.pumpWidget(createWidgetForTesting(
          child: TodoWidget(
            item: todo,
        onTap: tapCompleter.complete,
        onChanged: checkCompleter.complete,
      )));
      final titleFinder = find.text(todo.title);
      final descFinder = find.text(todo.desc);
      final dateFinder = find.text(DateFormat('d/M/y').format(todo.date));
      final checkBoxFinder = find.byType(Checkbox);
      expect(titleFinder, findsOneWidget);
      expect(descFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);
      expect(checkBoxFinder, findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('hello')));
      expect(tapCompleter.isCompleted, isTrue);
      await tester.tap(checkBoxFinder);
      expect(checkCompleter.isCompleted, isTrue);
    });
  });
}
