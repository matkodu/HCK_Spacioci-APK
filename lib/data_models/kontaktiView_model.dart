import 'package:hck_locat_test1/data_models/base_model.dart';
import 'package:hck_locat_test1/data_models/user.dart';
import 'package:hck_locat_test1/services/dialog_service.dart';
import 'package:hck_locat_test1/services/firestore_service.dart';
import 'package:hck_locat_test1/services/locator.dart';

class KontaktiViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<User> _kontakti;
  List<User> get kontakti => _kontakti;

  void listenToKontakti() {
    setBusy(true);
    _firestoreService.listenToKontaktirealTime().listen((kontaktiData) {
      List<User> updatedKont = kontaktiData;
      if (updatedKont != null && updatedKont.length > 0) {
        _kontakti = updatedKont;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future delteKontakt(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Jeste li sigurni?',
      description: 'Želite li izbrisati odabrani kontakt?',
      confirmationTitle: 'Da',
      cancelTitle: 'Ne',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteKontakt(_kontakti[index].id);
      setBusy(false);
    }
  }
}
