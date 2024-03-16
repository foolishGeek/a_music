import 'package:a_music/screens/authenticate/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:a_music/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_mock.dart' as mockFirebase;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  mockFirebase.setupFirebaseAuthMocks();
  setUp(() async{
    await Firebase.initializeApp();
  });

  group('Login Integration test', () {
    testWidgets('Login test', (widgetTester) async{
      SharedPreferences.setMockInitialValues({});
      app.main();
      await widgetTester.pumpWidget(const AuthenticateUser());
      await widgetTester.enterText(find.byKey(const Key('email_text_field')), "avijitarm@gmail.com");
      await widgetTester.enterText(find.byKey(const Key('password_text_field')), "Test@123");
      await widgetTester.tap(find.byKey(const Key('button')));
      await widgetTester.pumpAndSettle();
      expect(find.text('Great, Please wait...'), findsOneWidget);
    });
  });
}