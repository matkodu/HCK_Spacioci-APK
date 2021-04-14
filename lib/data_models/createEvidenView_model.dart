import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/base_model.dart';
import 'package:hck_locat_test1/data_models/evidencija.dart';
import 'package:hck_locat_test1/services/dialog_service.dart';
import 'package:hck_locat_test1/services/firestore_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';

class CreateEvidenViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Evidencija _edittingEviden;

  void setEdittingEviden(Evidencija evidencija) {
    _edittingEviden = evidencija;
  }

  bool get _edittingE => _edittingEviden != null;

  Future addEviden(
      {@required String ime,
      @required String dateTime,
      @required double lat,
      @required double long,
      @required String plaza,
      @required String tip}) async {
    setBusy(true);

    var result;

    if (!_edittingE) {
      result = await _firestoreService.addEviden(
        Evidencija(
            ime: ime,
            dateTime: dateTime,
            lat: lat,
            long: long,
            plaza: plaza,
            tip: tip,
            userId: currentUser.id),
      ); // We need to add the current userId
    } else {
      result = await _firestoreService.updateEviden(Evidencija(
        ime: ime,
        dateTime: dateTime,
        lat: lat,
        long: long,
        plaza: plaza,
        tip: tip,
        userId: _edittingEviden.userId,
        documentId: _edittingEviden.documentId,
      ));
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Nije moguće dodati dokument',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Lokacija uspješno poslana',
        description: 'Stvorili ste novi dokument.',
      );
    }

    _navigationService.pop();
  }
}
