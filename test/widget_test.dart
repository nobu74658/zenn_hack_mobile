// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zenn_hack_mobile/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ZennHackMobileApp());

    expect(find.text('Zenn Hack Mobile'), findsOneWidget);
    expect(find.text('English Learning App'), findsOneWidget);
    expect(find.text('Architecture setup complete!'), findsOneWidget);
    expect(find.byIcon(Icons.school), findsOneWidget);
  });
}
