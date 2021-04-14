import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/homeView_model.dart';
import 'package:hck_locat_test1/data_models/user_location.dart';
import 'package:hck_locat_test1/services/authentication_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/shared/busy_button.dart';
import 'package:hck_locat_test1/shared/route_names.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
import 'package:hck_locat_test1/views/gmap_view.dart';
import 'package:hck_locat_test1/views/kontakti_spas_view.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:trust_location/trust_location.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    var userLocation = Provider.of<UserLocation>(context);
    final NavigationService _navigationService = locator<NavigationService>();
    final AuthenticationService _authenticationService =
        locator<AuthenticationService>();

    // ignore: missing_required_param
    return ViewModelProvider<HomeViewModel>.withConsumer(
        // ignore: deprecated_member_use
        viewModel: HomeViewModel(),
        builder: (context, model, child) => Scaffold(
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
                title: Text('Lokacija'),
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
                      accountEmail:
                          Text('${_authenticationService.currentUser.email}'),
                    ),
                    /*
                    ListTile(
                      title: Text('Raspored'),
                      onTap: () {},
                    ),
                    */
                    ListTile(
                      title: Text('Kontakti'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KontaktSpasView()));
                      },
                    ),
                    ListTile(
                      title: Text('Izvještaj'),
                      onTap: () {
                        _navigationService.navigateTo(CreatePostViewRoute);
                      },
                    )
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ExpansionTile(
                        title: Text(model.selectedType),
                        children: <Widget>[
                          //Text("${userLocation.latitude}"),
                          ListTile(
                            title: Text('Dolazak'),
                            onTap: () {
                              model.setSelectedType('Dolazak');
                            },
                          ),
                          ListTile(
                            title: Text('Odlazak'),
                            onTap: () {
                              model.setSelectedType('Odlazak');
                            },
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(model.selectedBeach),
                        children: <Widget>[
                          ListTile(
                            title: Text('Danče'),
                            onTap: () {
                              model.setSelectedBeach('Danče');
                            },
                          ),
                          ListTile(
                            title: Text('Bellevue'),
                            onTap: () {
                              model.setSelectedBeach('Bellevue');
                            },
                          ),
                          ListTile(
                            title: Text('Šulić'),
                            onTap: () {
                              model.setSelectedBeach('Šulić');
                            },
                          ),
                          ListTile(
                            title: Text('Mandrač'),
                            onTap: () {
                              model.setSelectedBeach('Mandrač');
                            },
                          ),
                          ListTile(
                            title: Text('Štikovica'),
                            onTap: () {
                              model.setSelectedBeach('Štikovica');
                            },
                          ),
                          ListTile(
                            title: Text('Zaton'),
                            onTap: () {
                              model.setSelectedBeach('Zaton');
                            },
                          ),
                          ListTile(
                            title: Text('Orašac'),
                            onTap: () {
                              model.setSelectedBeach('Orašac');
                            },
                          ),
                        ],
                      ),
                      verticalSpaceLarge,
                      // ignore: deprecated_member_use
                      BusyButton(
                        onPressed: () async {
                          bool isMockLocation =
                              await TrustLocation.isMockLocation;
                          bool serviceEnabled =
                              await Location().serviceEnabled();

                          if ((isMockLocation != null) &&
                              (serviceEnabled != null)) {
                            Map<String, dynamic> mapE = {
                              "lat": userLocation.latitude,
                              "long": userLocation.longitude,
                              "dateTime":
                                  "Datum: ${now.day}.${now.month}. Vrijeme: ${now.hour}:${now.minute}",
                              "ime":
                                  _authenticationService.currentUser.fullName,
                              "tip": model.selectedType,
                              "plaza": model.selectedBeach,
                              "userId": _authenticationService.currentUser.id,
                            };

                            var result = await Firestore.instance
                                .collection("Evidencije")
                                .add(mapE);
                            if (result != null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Uspješno poslana lokacija."),
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Neuspješno poslana lokacija. Pokušajte ponovo."),
                                    );
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Neuspješno poslana lokacija. Pokušajte ponovo."),
                                  );
                                });
                          }
                        },
                        title: 'Pošalji lokaciju',
                      ),
                    ],
                  )),
              floatingActionButton: FloatingActionButton(
                tooltip: 'Provjeri na karti',
                child: Icon(Icons.location_on_outlined),
                backgroundColor: Colors.grey[850],
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GMap()));
                },
              ),
            ));
  }
}
