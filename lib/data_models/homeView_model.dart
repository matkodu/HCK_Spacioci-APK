import 'package:hck_locat_test1/data_models/base_model.dart';

class HomeViewModel extends BaseModel {
  String _selectedType = 'Dolazak/Odlazak';
  String get selectedType => _selectedType;

  String _selectedBeach = 'Odaberi plažu';
  String get selectedBeach => _selectedBeach;

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void setSelectedBeach(String beach) {
    _selectedBeach = beach;
    notifyListeners();
  }
}
