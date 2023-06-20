import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kamed/models/user.dart';
import 'package:kamed/providers/user_provider.dart';
import 'package:kamed/resource/firestore_methods.dart';
// import 'package:kamed/screen/feed_screen.dart';
import 'package:kamed/utils/colors.dart';
import 'package:kamed/utils/utils.dart';
import 'package:kamed/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentBarangScreen extends StatefulWidget {
  final postId;
  const CommentBarangScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentBarangScreenState createState() => _CommentBarangScreenState();
}

class _CommentBarangScreenState extends State<CommentBarangScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void BarangComment(String uid, String name, String profilePic) async {
    try {
      String res = await FireStoreMethods().BarangComment(
        widget.postId,
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        showSnackBar(context, res);
      }
      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Komentar',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Mengatur warna ikon back menjadi hitam
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('jual')
            .doc(widget.postId)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => CommentCard(
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commentEditingController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Komentar ${user.username}',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => BarangComment(
                  user.uid,
                  user.username,
                  user.photoUrl,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}