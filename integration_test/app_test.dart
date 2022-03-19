import 'package:bloc_login/keys.dart';
import 'package:bloc_login/main.dart';
import 'package:bloc_login/presentation/pages/welcome.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  //Here the user is been logged out
  Future<void> logout(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey(Keys.logoutKey),
    ));

    await addDelay(4000);
    tester.printToConsole('Welcome screen opens');
    //tap on the login button and open the forgot password screen
    final Finder showLoginScreenBtn = find.byKey(const ValueKey(Keys.showLoginScreenBtn));
    await tester.tap(showLoginScreenBtn, warnIfMissed: true);
    await addDelay(4000);
    //open the forgot password screen
    final Finder showForgotPBtn = find.byKey(const ValueKey(Keys.forgotPassword));
    await tester.tap(showForgotPBtn, warnIfMissed: true);
    await addDelay(4000);
    await tester.pumpAndSettle();
  }

  //verifies the integration test driver’s initialization
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
    as IntegrationTestWidgetsFlutterBinding;

    if (binding is LiveTestWidgetsFlutterBinding) {
      binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    }
//method groups and runs many tests.
    group('end-to-end test', () {
      //This code creates a time-based email address.
      final timeBasedEmail = DateTime.now().microsecondsSinceEpoch.toString() + '@gmail.com';

      testWidgets('SignUp Testing', (WidgetTester tester) async {
        tester.printToConsole(timeBasedEmail);
        //renders the UI of the provided widget
        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();
// Enumerate all states that exist in the app just to show we can
        print("All states: ");
        for (var s in tester.allStates) {
          print(s);
        }
/*Sign Up*/
        // Tap btn
        final Finder signUpBtn = find.byKey(const ValueKey(Keys.signUpBtn));
        await tester.ensureVisible(find.byKey(const Key(Keys.signUpBtn)));
        await tester.tap(signUpBtn, warnIfMissed: true);

        //await tester.tap(find.byType(ElevatedButton));

        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(const ValueKey(Keys.emailSignupKey)), 'testme@gmail.com');
        await tester.enterText(find.byKey(const ValueKey(Keys.passwordSignupKey)), '12345678');
        await tester.enterText(find.byKey(const ValueKey(Keys.cPasswordSignupKey)), '12345678');
        //await tester.tap(find.byType(ElevatedButton));
        final Finder signupBtn = find.byKey(const ValueKey(Keys.signupBtn));

        await tester.tap(signupBtn, warnIfMissed: true);

        //await addDelay(24000);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 5));

        await logout(tester);


      /*Forgot password*/

        // Find textField and button
        final Finder verifyEmailText = find.byKey(const ValueKey(Keys.verifyEmailText));
        final Finder verifyEmailBtn = find.byKey(const ValueKey(Keys.verifyEmailBtn));

        // Ensure there is an email field and a button on the forgot password page
        expect(verifyEmailText, findsOneWidget);
        expect(verifyEmailBtn, findsOneWidget);

        // Enter text
        tester.printToConsole(timeBasedEmail);
        await tester.enterText(verifyEmailText, 'testme@gmail.com');

        // Tap btn to verify email is stored in the storage
        await tester.tap(verifyEmailBtn, warnIfMissed: true);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 5));

        //Enter Otp text
        final Finder verifyOtpText = find.byKey(const ValueKey(Keys.verifyOtpText));
        await tester.enterText(verifyOtpText, '12345678');


        // Tap btn to verify otp sent
        final Finder verifyOtpBtn = find.byKey(const ValueKey(Keys.verifyOtpBtn));
        await tester.tap(verifyOtpBtn, warnIfMissed: true);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 5));

        //update password screen

        // Find textField and button
        final Finder forgotPasswordText = find.byKey(const ValueKey(Keys.forgotPasswordText));
        final Finder forgotCPasswordText = find.byKey(const ValueKey(Keys.forgotCPasswordText));
        final Finder updatePasswordBtn = find.byKey(const ValueKey(Keys.updatePasswordBtn));

        // Enter text

        await tester.enterText(forgotPasswordText, 'abc12345678');
        await tester.enterText(forgotCPasswordText, 'abc12345678');

        //tap btn to update password in the storage
        await tester.tap(updatePasswordBtn, warnIfMissed: true);
        await addDelay(2000);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 5));


       /*Login screen opens here*/


        final Finder showLoginScreenBtn = find.byKey(const ValueKey(Keys.showLoginScreenBtn));
        await tester.tap(showLoginScreenBtn, warnIfMissed: true);
        await addDelay(2000);
        await tester.enterText(find.byKey(const ValueKey(Keys.emailLoginField)), 'testme@gmail.com');
        await tester.enterText(find.byKey(const ValueKey(Keys.passwordLoginField)), 'abc12345678');
        await tester.tap(find.byType(ElevatedButton));

        //Home Test
        await tester.pump(const Duration(seconds: 5));
        expect(find.text('Auric Home'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);

        await addDelay(120000);



});

    });
  }
