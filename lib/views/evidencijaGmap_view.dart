import 'package:hck_locat_test1/data_models/evidencija.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapEviden extends StatefulWidget {
  final Evidencija evidencija;
  GMapEviden({Key key, this.evidencija}) : super(key: key);

  @override
  _GMapStateEviden createState() => _GMapStateEviden();
}

class _GMapStateEviden extends State<GMapEviden> {
  GoogleMapController _mapController;

  List<Marker> allMarkers = [];
  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId("${widget.evidencija.ime}"),
      position: LatLng(widget.evidencija.lat, widget.evidencija.long),
      draggable: false,
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Karta'),
          centerTitle: true,
          backgroundColor: Colors.grey[400],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.evidencija.lat, widget.evidencija.long),
            zoom: 17,
          ),
          markers: Set.from(allMarkers),
        ));
  }
}
