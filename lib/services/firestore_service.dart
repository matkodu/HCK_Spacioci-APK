import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hck_locat_test1/data_models/evidencija.dart';
import 'package:hck_locat_test1/data_models/post.dart';
import 'package:hck_locat_test1/data_models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection("users");
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection("posts");
  final CollectionReference _evidenCollectionReference =
      Firestore.instance.collection("Evidencije");

  // Create the controller that will broadcast the posts
  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  final StreamController<List<Evidencija>> _evidenController =
      StreamController<List<Evidencija>>.broadcast();

  final StreamController<List<User>> _userController =
      StreamController<List<User>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      return e.message;
    }
  }

  Future addEviden(Evidencija evidencija) async {
    try {
      await _evidenCollectionReference.add(evidencija.toMapE());
    } catch (e) {
      return e.message;
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocuments = await _postsCollectionReference.getDocuments();
      if (postDocuments.documents.isNotEmpty) {
        return postDocuments.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getEvidenOnceOff() async {
    try {
      var evidenDocuments = await _evidenCollectionReference.getDocuments();
      if (evidenDocuments.documents.isNotEmpty) {
        return evidenDocuments.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToKontaktirealTime() {
    // Register the handler for when the posts data changes
    _usersCollectionReference.snapshots().listen((userSnapshot) {
      if (userSnapshot.documents.isNotEmpty) {
        var kontakts = userSnapshot.documents
            .map((snapshotk) => User.fromData(snapshotk.data))
            .where((mappedItemk) => mappedItemk.fullName != null)
            .toList();

        // Add the posts onto the controller
        _userController.add(kontakts);
      }
    });

    // Return the stream underlying our _postsController.
    return _userController.stream;
  }

  Stream listenToEvidenRealTime() {
    // Register the handler for when the posts data changes
    _evidenCollectionReference.snapshots().listen((evidensSnapshot) {
      if (evidensSnapshot.documents.isNotEmpty) {
        var evidens = evidensSnapshot.documents
            .map((snapshot) =>
                Evidencija.fromMapE(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.ime != null)
            .toList();

        // Add the posts onto the controller
        _evidenController.add(evidens);
      }
    });

    // Return the stream underlying our _postsController.
    return _evidenController.stream;
  }

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _postsController.stream;
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.document(documentId).delete();
  }

  Future deleteEviden(String documentId) async {
    await _evidenCollectionReference.document(documentId).delete();
  }

  Future deleteKontakt(String uid) async {
    await _usersCollectionReference.document(uid).delete();
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference
          .document(post.documentId)
          .updateData(post.toMap());
      return true;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future updateEviden(Evidencija evidencija) async {
    try {
      await _evidenCollectionReference
          .document(evidencija.documentId)
          .updateData(evidencija.toMapE());
      return true;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
