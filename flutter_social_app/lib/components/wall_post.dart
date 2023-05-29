import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_app/components/like_button.dart';

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
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              // like button
              LikeButton(isLiked: isLiked, onTap: toggleLike),
              //like counter
              Text(widget.likes.length.toString(),
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user, style: TextStyle(color: Colors.grey[500])),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          ),
        ],
      ),
    );
  }
}
