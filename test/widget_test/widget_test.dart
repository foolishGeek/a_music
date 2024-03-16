import 'package:a_music/screens/authenticate/authentication.dart';
import 'package:a_music/screens/authenticate/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Log In', (widgetTester) async {
    await widgetTester.pumpWidget(const AuthenticateUser());

    final logInWidget = find.byType(LoginCard);
    expect(logInWidget, findsOneWidget);
  });

  testWidgets('Text fields', (widgetTester) async {
    await widgetTester.pumpWidget(const AuthenticateUser());

    final logInTextField = find.byType(TextField);
    expect(logInTextField, findsNWidgets(2));
  });

  testWidgets("Text field value", (widgetTester) async {
    await widgetTester.pumpWidget(const AuthenticateUser());

    final logInTextField = find.byType(TextField);
    final emailTextField =
    widgetTester.firstWidget(logInTextField) as TextField;
    emailTextField.controller?.text = "avijit@gmail.com";
    expect(emailTextField.controller?.text == "avijit@gmail.com", isTrue);
  });
}
