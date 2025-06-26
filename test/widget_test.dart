// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manage/main.dart'; // Update this if your project name is different

// 1. Create a mock class
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  // 2. Setup before tests
  setUp(() {
    mockPrefs = MockSharedPreferences();
  });

  testWidgets('App renders TODO List title', (WidgetTester tester) async {
    // 3. Mock SharedPreferences behavior
    when(() => mockPrefs.getStringList('tasks')).thenReturn([]);

    // 4. Load app with mocked SharedPreferences
    await tester.pumpWidget(MyApp(prefs: mockPrefs));

    // 5. Verify something is on screen
    expect(find.text('TODO List'), findsOneWidget);
  });
}
