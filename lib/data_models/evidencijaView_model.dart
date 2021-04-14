import 'package:hck_locat_test1/data_models/base_model.dart';
import 'package:hck_locat_test1/data_models/evidencija.dart';
import 'package:hck_locat_test1/services/dialog_service.dart';
import 'package:hck_locat_test1/services/firestore_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';
import 'package:hck_locat_test1/shared/route_names.dart';

class EvidencijaViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Evidencija> _evidens;
  List<Evidencija> get evidens => _evidens;

  void listenToEvidens() {
    setBusy(true);
    _firestoreService.listenToEvidenRealTime().listen((evidensData) {
      List<Evidencija> updatedEvidens = evidensData;
      if (updatedEvidens != null && updatedEvidens.length > 0) {
        _evidens = updatedEvidens;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future deleteEviden(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Jeste li sigurni?',
      description: 'Želite li izbrisati odabrani dokument?',
      confirmationTitle: 'Da',
      cancelTitle: 'Ne',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteEviden(_evidens[index].documentId);
      setBusy(false);
    }
  }
  /*
  Future navigateToCreateEvidenView() async {
    await _navigationService.navigateTo(CreateEvidenViewRoute);
  }
  */
  /*
  void editEviden(int index) {
    _navigationService.navigateTo(CreateEvidenViewRoute,
        arguments: _evidens[index]);
  }
  */
}
