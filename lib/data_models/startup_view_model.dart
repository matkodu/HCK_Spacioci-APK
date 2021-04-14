import 'package:hck_locat_test1/services/authentication_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/shared/route_names.dart';

import 'base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      if ('${_authenticationService.currentUser.userRole}' == 'Spasioc') {
        _navigationService.navigateTo(HomeViewRoute);
      } else if ('${_authenticationService.currentUser.userRole}' ==
          'Voditelj') {
        _navigationService.navigateTo(VoditeljHomeRoute);
      }
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
