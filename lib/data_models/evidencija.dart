import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Evidencija {
  final String dateTime;
  final String ime;
  final double lat;
  final double long;
  final String plaza;
  final String tip;
  final String userId;
  final String documentId;
  Evidencija(
      {@required this.userId,
      @required this.ime,
      this.dateTime,
      this.documentId,
      this.lat,
      this.long,
      this.plaza,
      this.tip});

  Map<String, dynamic> toMapE() {
    return {
      'userId': userId,
      'ime': ime,
      'dateTime': dateTime,
      'lat': lat,
      'long': long,
      'plaza': plaza,
      'tip': tip,
    };
  }

  static Evidencija fromMapE(Map<String, dynamic> mapE, String documentId) {
    if (mapE == null) return null;

    return Evidencija(
      dateTime: mapE['dateTime'],
      ime: mapE['ime'],
      lat: mapE['lat'],
      long: mapE['long'],
      plaza: mapE['plaza'],
      tip: mapE['tip'],
      userId: mapE['userId'],
      documentId: documentId,
    );
  }
}
