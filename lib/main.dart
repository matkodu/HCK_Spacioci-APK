import 'package:flutter/material.dart';
import 'package:hck_locat_test1/router.dart';
import 'package:hck_locat_test1/services/dialog_service.dart';
import 'package:hck_locat_test1/services/location_service.dart';

import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/views/sign_in.dart';
import 'package:hck_locat_test1/views/startup_view.dart';

import 'package:provider/provider.dart';

import 'data_models/user_location.dart';
import 'managers/dialog_managers.dart';

void main() async {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<UserLocation>(
        // ignore: deprecated_member_use
        create: (context) => LocationService().locationStream,
        child: MaterialApp(
          title: 'HCK-Spasioci',
          builder: (context, child) => Navigator(
            key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(child: child)),
          ),
          navigatorKey: locator<NavigationService>().navigationKey,
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 9, 202, 172),
            backgroundColor: Color.fromARGB(255, 26, 27, 30),
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Open Sans',
                ),
          ),
          home: StartUpView(),
          onGenerateRoute: generateRoute,
        ));
  }
}
