import 'package:FARTS/authwrapper.dart';
import 'package:FARTS/homepage.dart';
import 'package:FARTS/loginpage.dart';
<<<<<<< HEAD
import 'package:FARTS/selectmodepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
import 'package:FARTS/models/user.dart';
>>>>>>> 1c74b7fb89cf5200ac9befb5fb18130bb88d913a
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUser extends Mock implements User {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('App navigates to correct page based on firebaseuser', () {
    testWidgets('Application goes to loginpage when user is null',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: AuthWrapper().showCorrectPage(null),
          navigatorObservers: [mockObserver],
        ),
      );
      verify(mockObserver.didPush(any, any));
      expect(find.byType(LoginPage), findsOneWidget);
    });
    testWidgets('Application loads homepage when user is not null',
        (WidgetTester tester) async {
      final mockUser = new MockUser();
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: AuthWrapper().showCorrectPage(mockUser),
          navigatorObservers: [mockObserver],
        ),
      );
      verify(mockObserver.didPush(any, any));
      expect(find.byType(SelectModePage), findsOneWidget);
    });
  });
}
