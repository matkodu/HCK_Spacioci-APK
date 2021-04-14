import 'package:get_it/get_it.dart';
import 'package:hck_locat_test1/services/firestore_service.dart';

import 'authentication_service.dart';
import 'dialog_service.dart';
import 'navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}
