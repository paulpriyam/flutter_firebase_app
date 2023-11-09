import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/post_model.dart';
import 'package:flutter_firebase/utils/utils.dart';
import 'package:flutter_firebase/widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

final _formKey = GlobalKey<FormState>();
final database = FirebaseDatabase.instance.ref("Post");
final postController = TextEditingController();
final postTitleController = TextEditingController();

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title cannot be null";
                      }
                      return null;
                    },
                    controller: postTitleController,
                    decoration: InputDecoration(
                        label: const Text("Title"),
                        hintText: "Enter Title of Post",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "post cannot be empty";
                      }
                      return null;
                    },
                    controller: postController,
                    decoration: const InputDecoration(
                        label: Text("Post"),
                        hintText: "What's in your mind?",
                        border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtonTxt(
                buttonText: "Post",
                onTap: () {
                  String id = const Uuid().v4();
                  PostModel postModel = PostModel(
                      id: id,
                      postTitle: postTitleController.text.toString(),
                      postDesc: postController.text.toString(),
                      timeStamp:
                          DateTime.now().millisecondsSinceEpoch.toString());
                  database.child(id).set(postModel.toJosn()).then((value) {
                    Utility()
                        .showToastMessage("Post successfully added", false);
                  }).onError((error, stackTrace) {
                    Utility().showToastMessage(error.toString(), true);
                  });
                })
          ],
        ),
      ),
    );
  }
}
