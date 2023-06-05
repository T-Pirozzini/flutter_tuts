import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/like_button.dart';

import 'comment_button.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.postId,
      required this.likes});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // text controller
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      // access the doc in firebase
      DocumentReference postRef = FirebaseFirestore.instance
          .collection('User Posts')
          .doc(widget.postId);

      if (isLiked) {
        // if the post is now liked, add the user's email to the 'Likes'
        postRef.update({
          'Likes': FieldValue.arrayUnion([currentUser.email])
        });
      } else {
        // if the post is now unliked, remove the user's email from the 'Likes'
        postRef.update({
          'Likes': FieldValue.arrayRemove([currentUser.email])
        });
      }
    });
  }

  // add a comment
  void addComment(String commentText) {
    // write a comment to firsttore under the comments collection for this post
    FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(), // format this later
    });
  }

  // show dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a comment'),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(
            hintText: 'Write a comment...',
          ),
        ),
        actions: [
          // cancel button
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
          ),

          // save button
          TextButton(
            child: const Text('Post'),
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // message and user email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user, style: TextStyle(color: Colors.grey[500])),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          ),

          const SizedBox(width: 20),

          //buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LIKE
              Column(
                children: [
                  // like button
                  LikeButton(isLiked: isLiked, onTap: toggleLike),
                  const SizedBox(height: 5),
                  //like counter
                  Text(widget.likes.length.toString(),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),

              const SizedBox(width: 10),

              // COMMENT
              Column(
                children: [
                  // comment button
                  CommentButton(onTap: showCommentDialog),
                  const SizedBox(height: 5),
                  // comment counter
                  const Text('0', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
