import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/izvjestajView_model.dart';
import 'package:hck_locat_test1/shared/post_item.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
import 'package:path_provider/path_provider.dart';

import 'package:stacked/stacked.dart';

class IzvjestajView extends StatelessWidget {
  const IzvjestajView({Key key}) : super(key: key);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("$path");
    return File('$path/data.txt');
  }

  Future<File> writeContent() async {
    final file = await _localFile;
    // Write the file

    return file.writeAsString('Hello Folks');
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IzvjestajViewModel>.reactive(
        viewModelBuilder: () => IzvjestajViewModel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("Uređivanje izvještaja"),
                backgroundColor: Colors.grey[400],
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(35),
                    Expanded(
                        child: model.posts != null
                            ? ListView.builder(
                                itemCount: model.posts.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                        onTap: () => model.editPost(index),
                                        child: PostItem(
                                          post: model.posts[index],
                                          onDeleteItem: () =>
                                              model.deletePost(index),
                                        )),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              )),
                    Stack(
                      children: <Widget>[
                        /*
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: FloatingActionButton(
                            backgroundColor: Colors.grey[850],
                            child: !model.busy
                                ? Icon(Icons.download_sharp)
                                : CircularProgressIndicator(),
                            onPressed: () {
                              writeContent();
                            },
                          ),
                        ), */
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: Colors.grey[850],
                            child: !model.busy
                                ? Icon(Icons.add)
                                : CircularProgressIndicator(),
                            onPressed: model.navigateToCreateView,
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceMedium
                  ],
                ),
              ),
            ));
  }
}
