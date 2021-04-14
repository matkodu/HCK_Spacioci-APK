import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/evidencija.dart';
import 'package:hck_locat_test1/views/evidencijaGmap_view.dart';

class EvidenItem extends StatelessWidget {
  final Evidencija evidencija;
  final Function onDeleteItem;
  const EvidenItem({Key key, this.evidencija, this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.location_on_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GMapEviden(evidencija: evidencija),
                    ));
              }),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
                "${evidencija.dateTime},      ${evidencija.plaza}:                  ${evidencija.ime}   -   ${evidencija.tip}"),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    );
  }
}
