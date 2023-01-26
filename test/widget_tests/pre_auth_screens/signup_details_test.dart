import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talawa/models/organization/org_info.dart';
import 'package:talawa/models/user/user_info.dart';
import 'package:talawa/router.dart' as router;
import 'package:talawa/services/navigation_service.dart';
import 'package:talawa/services/size_config.dart';
import 'package:talawa/utils/app_localization.dart';
import 'package:talawa/views/pre_auth_screens/signup_details.dart';

import '../../helpers/test_locator.dart';

Widget createApp() {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: [
      const AppLocalizationsDelegate(isTest: true),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    home: TextButton(
      onPressed: () async {
        final OrgInfo org = OrgInfo(
          id: '2',
          name: 'test org',
          isPublic: false,
          creatorInfo: User(firstName: 'test', lastName: 'test'),
        );

        await navigationService.pushScreen('/signupDetails', arguments: org);
      },
      child: const Text('Ayush'),
    ),
    navigatorKey: locator<NavigationService>().navigatorKey,
    onGenerateRoute: router.generateRoute,
  );
}

Future<void> showSignUpScreen(tester) async {
  await tester.pumpWidget(createApp());
  await tester.pump();
  await tester.tap(find.textContaining('Ayush'));
  await tester.pumpAndSettle();
}

void main() {
  SizeConfig().test();
  testSetupLocator();

  group('Test For SignUp Screen', () {
    testWidgets('Check if SignUp screen shows up', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pump();

      expect(find.byType(SignUpDetails), findsNothing);

      await tester.tap(find.textContaining('Ayush'));
      await tester.pumpAndSettle();

      expect(find.byType(SignUpDetails), findsOneWidget);
    });
  });
}
