import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:talawa/models/organization/org_info.dart';
import 'package:talawa/models/user/user_info.dart';
import 'package:talawa/services/graphql_config.dart';
import 'package:talawa/services/size_config.dart';
import 'package:talawa/utils/queries.dart';
import 'package:talawa/view_model/pre_auth_view_models/select_organization_view_model.dart';
import 'package:talawa/widgets/custom_list_tile.dart';
import 'package:talawa/widgets/organization_list.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_locator.dart';

void main() {
  setUp(() {
    registerViewModels();
    registerServices();
    locator.registerFactory(() => Queries());
  });

  SizeConfig().test();
  Widget createOrgList({required SelectOrganizationViewModel model}) {
    return MaterialApp(home: Scaffold(body: OrganizationList(model: model)));
  }

  tearDown(() {
    unregisterViewModels();
    unregisterServices();
    locator.unregister<Queries>();
  });
  group('Test to check if GraphQlProvider is bulit', () {
    testWidgets('Test whether the GraphQLProvider is built when nothing passed',
        (tester) async {
      await tester.runAsync(() async {
        final SelectOrganizationViewModel model = SelectOrganizationViewModel();
        model.organizations = [];
        await tester.pumpWidget(createOrgList(model: model));
        await tester.pumpAndSettle();
        expect(find.byType(GraphQLProvider), findsOneWidget);
      });
    });

    testWidgets(
        'Test whether the GraphQLProvider is built when value are passed',
        (widgetTester) async {
      await widgetTester.runAsync(() async {});
    });
  });

  // testWidgets('Test for the loading bar while fetching data',
  //     (widgetTester) async {
  //   widgetTester.pumpWidget();
  //   widgetTester.pump();
  //   expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  // });
  // testWidgets('Displays list of organizations', (tester) async {
  //   // Create a mock SelectOrganizationViewModel object
  //   model.organizations = organizations;
  //   // Set up the widget
  //   await tester.pumpWidget(
  //     GraphQLProvider(
  //       client: ValueNotifier<GraphQLClient>(graphqlConfig.clientToQuery()),
  //       child: OrganizationList(model: model),
  //     ),
  //   );
  //
  //   // Pump the widget again to trigger a rebuild
  //   await tester.pump();
  //
  //   // The widget should display 2 CustomListTile widgets
  //   expect(find.byType(CustomListTile), findsNWidgets(2));
  // });
}

//setup and teardown
