import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/base_model.dart';
import 'package:hck_locat_test1/data_models/post.dart';
import 'package:hck_locat_test1/services/dialog_service.dart';
import 'package:hck_locat_test1/services/firestore_service.dart';
import 'package:hck_locat_test1/services/locator.dart';
import 'package:hck_locat_test1/services/navigation_service.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Post _edittingPost;

  void setEdittingPost(Post post) {
    _edittingPost = post;
  }

  bool get _editting => _edittingPost != null;

  Future addPost({@required String title, @required String opis}) async {
    setBusy(true);

    var result;

    if (!_editting) {
      result = await _firestoreService.addPost(
        Post(title: title, userId: currentUser.id, opis: opis),
      ); // We need to add the current userId
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        opis: opis,
      ));
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Nije moguće dodati izvještaj',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Izvještaj uspješno poslan',
        description: 'Stvorili ste novi izvještaj.',
      );
    }

    _navigationService.pop();
  }
}
