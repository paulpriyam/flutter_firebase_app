import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/add_post.dart';
import 'package:flutter_firebase/ui/login_screen.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final database = FirebaseDatabase.instance.ref("Post");

String epochToDate(String epoch) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(epoch));
  String date = DateFormat("yyyy-MM-dd").format(dateTime);
  return date;
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPostScreen()));
          }),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Post"),
        actions: [
          InkWell(
              onTap: () {
                auth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Icon(Icons.logout)),
          const SizedBox(
            width: 16,
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: database,
              itemBuilder: (context, snapshot, animation, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all()),
                    child: ListTile(
                      title: Text(snapshot.child("postTitle").value.toString()),
                      titleTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      subtitle: ListTile(
                        title:
                            Text(snapshot.child("postDesc").value.toString()),
                        subtitle: Text(epochToDate(
                            snapshot.child("timeStamp").value.toString())),
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
          ),
        ],
      ),
    );
  }
}
