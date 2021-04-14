import 'package:flutter/material.dart';
import 'package:hck_locat_test1/services/authentication_service.dart';
import 'package:hck_locat_test1/services/dialog_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/shared/route_names.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({@required String email, @required String password}) async {
    setBusy(true);
    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    setBusy(false);
    if (result is bool) {
      if (result) {
        if ('${_authenticationService.currentUser.userRole}' == 'Spasioc') {
          _navigationService.navigateTo(HomeViewRoute);
        } else if ('${_authenticationService.currentUser.userRole}' ==
            'Voditelj') {
          _navigationService.navigateTo(VoditeljHomeRoute);
        }
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'Došlo je do pogreške. Pokušajte ponovo.',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
