import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/createPostView_model.dart';
import 'package:hck_locat_test1/data_models/post.dart';
import 'package:hck_locat_test1/shared/input_field.dart';
import 'package:hck_locat_test1/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final opisController = TextEditingController();
  final Post edittingPost;

  CreatePostView({Key key, this.edittingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = edittingPost?.title ?? '';
        opisController.text = edittingPost?.opis ?? '';
        // set the editting post
        model.setEdittingPost(edittingPost);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              // Call the function to create the post
              if (!model.busy)
                model.addPost(
                  title: titleController.text,
                  opis: opisController.text,
                );
            },
            backgroundColor: Colors.grey[850],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Izvještaj',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Naslov',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                Text('Detaljno opišite'),
                verticalSpaceSmall,
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Opis",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    maxLines: 10,
                    controller: opisController,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
