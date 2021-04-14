import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/kontaktiView_model.dart';
import 'package:hck_locat_test1/shared/eviden_item.dart';
import 'package:hck_locat_test1/shared/kontakt_item.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class KontaktiView extends StatelessWidget {
  const KontaktiView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KontaktiViewModel>.reactive(
        viewModelBuilder: () => KontaktiViewModel(),
        onModelReady: (model) => model.listenToKontakti(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("Kontakti"),
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
                        child: model.kontakti != null
                            ? ListView.builder(
                                itemCount: model.kontakti.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                        //onTap: () => model.editEviden(index),
                                        child: KontaktItem(
                                  kontakt: model.kontakti[index],
                                  onDeleteItem: () => model.delteKontakt(index),
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
