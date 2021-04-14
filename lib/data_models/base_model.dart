import 'package:flutter/widgets.dart';
import 'package:hck_locat_test1/data_models/user.dart';
import 'package:hck_locat_test1/services/authentication_service.dart';
import 'package:hck_locat_test1/services/locator.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
