import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/signup_view_model.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/shared/busy_button.dart';
import 'package:hck_locat_test1/shared/input_field.dart';
import 'package:hck_locat_test1/shared/route_names.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
//import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:provider_architecture/provider_architecture.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      // ignore: deprecated_member_use
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Registracija',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Ime i prezime',
                controller: fullNameController,
              ),
              InputField(
                placeholder: 'Email',
                controller: emailController,
              ),
              InputField(
                textInputType: TextInputType.number,
                placeholder: 'Broj mobitela',
                controller: phoneController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Zaporka',
                password: true,
                controller: passwordController,
                additionalNote: 'Zaporka mora sadržavati minimalno 6 znakova.',
              ),
              verticalSpaceSmall,
              ExpansionTile(
                title: Text(model.selectedRole),
                children: <Widget>[
                  ListTile(
                    title: Text('Voditelj'),
                    onTap: () {
                      // ignore: unnecessary_statements
                      model.setSelectedRole('Voditelj');
                    },
                  ),
                  ListTile(
                    title: Text('Spasioc'),
                    onTap: () {
                      // ignore: unnecessary_statements
                      model.setSelectedRole('Spasioc');
                    },
                  ),
                ],
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Registriraj se',
                    busy: model.busy,
                    onPressed: () {
                      model.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        fullName: fullNameController.text,
                        phone: phoneController.text,
                      );
                    },
                  )
                ],
              ),
              verticalSpaceSmall,
              BusyButton(
                  title: 'Povratak na početni ekran',
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    _navigationService.navigateTo(LoginViewRoute);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
