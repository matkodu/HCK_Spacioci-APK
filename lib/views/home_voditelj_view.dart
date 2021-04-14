import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_locat_test1/services/authentication_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/shared/route_names.dart';

class HomeVoditelj extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    final AuthenticationService _authenticationService =
        locator<AuthenticationService>();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              _navigationService.navigateTo(LoginViewRoute);
            },
          ),
        ],
        title: Text('Voditelj'),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
              accountName: Text(
                  '${_authenticationService.currentUser.fullName}, ${_authenticationService.currentUser.userRole}'),
              accountEmail: Text('${_authenticationService.currentUser.email}'),
            ),
            ListTile(
              title: Text('Uređivanje izvještaja'),
              onTap: () {
                _navigationService.navigateTo(IzvjestajViewRoute);
              },
            ),
            ListTile(
              title: Text('Registriraj novog člana'),
              onTap: () {
                _navigationService.navigateTo(SignUpViewRoute);
              },
            ),
            ListTile(
              title: Text('Evidencija lokacija'),
              onTap: () {
                _navigationService.navigateTo(EvidencijaViewRoute);
              },
            ),
            /*
            ListTile(
              title: Text('Dodaj raspored'),
              onTap: () {},
            ),
            */
            ListTile(
              title: Text('Kontakti'),
              onTap: () {
                _navigationService.navigateTo(KontaktiViewROute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
