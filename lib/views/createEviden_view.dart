import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/createEvidenView_model.dart';
import 'package:hck_locat_test1/data_models/evidencija.dart';
import 'package:hck_locat_test1/shared/input_field.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class CreateEvidenView extends StatelessWidget {
  final imeController = TextEditingController();
  final dateTimeController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final plazaController = TextEditingController();
  final tipController = TextEditingController();
  final Evidencija edittingEviden;

  CreateEvidenView({Key key, this.edittingEviden}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEvidenViewModel>.reactive(
        viewModelBuilder: () => CreateEvidenViewModel(),
        onModelReady: (model) {
          // update the text in the controller
          imeController.text = edittingEviden?.ime ?? '';
          dateTimeController.text = edittingEviden?.dateTime ?? '';
          latController.text = edittingEviden?.lat ?? '';
          longController.text = edittingEviden?.long ?? '';
          plazaController.text = edittingEviden?.plaza ?? '';
          tipController.text = edittingEviden?.tip ?? '';
          // set the editting post
          model.setEdittingEviden(edittingEviden);
        },
        builder: (context, model, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              child: !model.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
              onPressed: () {
                // Call the function to create the post
                if (!model.busy)
                  model.addEviden(
                    ime: imeController.text,
                    dateTime: dateTimeController.text,
                    plaza: plazaController.text,
                    tip: tipController.text,
                    lat: latController.text as double,
                    long: longController.text as double,
                  );
              },
              backgroundColor: Colors.grey[850],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  verticalSpace(40),
                  Text(
                    'Lokacija',
                    style: TextStyle(fontSize: 26),
                  ),
                  verticalSpaceMedium,
                  InputField(
                    placeholder: 'Ime',
                    controller: imeController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Datum i vrijeme',
                    controller: dateTimeController,
                  ),
                  InputField(
                    placeholder: 'Lat',
                    controller: latController,
                  ),
                  InputField(
                    placeholder: 'Long',
                    controller: longController,
                  ),
                  InputField(
                    placeholder: 'Plaža',
                    controller: plazaController,
                  ),
                  InputField(
                    placeholder: 'Tip',
                    controller: tipController,
                  ),
                ],
              ),
            )));
  }
}
