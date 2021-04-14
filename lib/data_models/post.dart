import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String opis;
  final String userId;
  final String documentId;
  Post({
    @required this.userId,
    @required this.title,
    this.opis,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'opis': opis,
    };
  }

  static Post fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Post(
      title: map['title'],
      opis: map['opis'],
      userId: map['userId'],
      documentId: documentId,
    );
  }
}
