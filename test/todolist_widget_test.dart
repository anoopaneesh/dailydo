import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/widgets/todolist.dart';

import 'mock_data.dart';


Widget createWidgetForTesting({required Widget child}) {
  return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(home: Scaffold(body: child)));
}
void main(){
  group('Todolist widget test', (){
    testWidgets('Todolist', (WidgetTester tester) async {
      final tapCompleter = Completer<void>();
      final todoToggle = Completer<void>();
      final todoDelete = Completer<void>();
      final list = MockData.mockTodosData;
      await tester.pumpWidget(createWidgetForTesting(child: Todolist(list: list, onTodoClick: tapCompleter.complete, onTodoToggle: todoToggle.complete, onTodoDelete: todoDelete.complete)));
      final titleFinder1 = find.text(MockData.mockTodosData[0].title);
      final titleFinder2 = find.text(MockData.mockTodosData[1].title);
      expect(titleFinder1, findsOneWidget);
      expect(titleFinder2, findsOneWidget);
      await tester.tap(find.byKey(ValueKey(MockData.mockTodosData[0].id)));
      await tester.tap(find.byKey(ValueKey('check-${MockData.mockTodosData[0].id}')));
      await tester.drag(find.byKey(ValueKey(MockData.mockTodosData[0].id)),const Offset(-500.0,0));
      await tester.pumpAndSettle();
      expect(tapCompleter.isCompleted, isTrue);
      expect(tapCompleter.isCompleted, isTrue);
      expect(todoDelete.isCompleted, isTrue);
    });
    
  });
}