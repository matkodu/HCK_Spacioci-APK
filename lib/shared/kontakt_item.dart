import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class KontaktItem extends StatelessWidget {
  final User kontakt;
  final Function onDeleteItem;
  const KontaktItem({Key key, this.kontakt, this.onDeleteItem})
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
            icon: Icon(Icons.call),
            onPressed: () {
              _makePhoneCall('tel:${kontakt.phoneNum}');
            },
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
                "${kontakt.fullName}    (${kontakt.userRole})   ${kontakt.phoneNum}"),
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

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
