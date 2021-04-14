import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/evidencijaView_model.dart';
import 'package:hck_locat_test1/shared/eviden_item.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class EvidencijaView extends StatelessWidget {
  const EvidencijaView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EvidencijaViewModel>.reactive(
        viewModelBuilder: () => EvidencijaViewModel(),
        onModelReady: (model) => model.listenToEvidens(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("Evidencija lokacija"),
                backgroundColor: Colors.grey[400],
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(35),
                    Expanded(
                        child: model.evidens != null
                            ? ListView.builder(
                                itemCount: model.evidens.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                        //onTap: () => model.editEviden(index),
                                        child: EvidenItem(
                                  evidencija: model.evidens[index],
                                  onDeleteItem: () => model.deleteEviden(index),
                                )),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              )),
                  ],
                ),
              ),
            ));
  }
}
