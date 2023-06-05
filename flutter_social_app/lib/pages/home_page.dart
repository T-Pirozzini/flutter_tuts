import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_social_app/components/text_field.dart";
import "package:flutter_social_app/components/wall_post.dart";
import "package:flutter_social_app/pages/profile_page.dart";
import "../components/drawer.dart";
import "../helper/helper_methods.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  void postMessage() {
    // only post if there is something in the text field
    if (textController.text.isNotEmpty) {
      // add message to firestore
      FirebaseFirestore.instance.collection('User Posts').add({
        'Message': textController.text,
        'UserEmail': currentUser.email,
        'TimeStamp': Timestamp.now(),
        "Likes": [],
      });
      // clear text field
      setState(() {
        textController.clear();
      });
    }
  }

  // navigate to profile page
  void goToProfilePage() {
    // pop menu drawer
    Navigator.pop(context);
    // go to new page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  // sign user out
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('The Wall'),
          backgroundColor: Colors.grey[800],
          // actions: [
          //   IconButton(
          //     onPressed: signOut,
          //     icon: const Icon(Icons.logout),
          //   ),
          // ],
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOutTap: signOut,
        ),
        body: Center(
          child: Column(
            children: [
              // the wall
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('User Posts')
                      .orderBy("TimeStamp", descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // get the message
                          final post = snapshot.data!.docs[index];
                          return WallPost(
                            message: post['Message'],
                            user: post['UserEmail'],
                            postId: post.id,
                            likes: List<String>.from(post['Likes'] ?? []),
                            time: formatDate(post['TimeStamp']),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const Text('Welcome to The Wall!'),
              // post message
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: textController,
                        hintText: 'Write something on the wall...',
                        obscureText: false,
                      ),
                    ),
                    // post button
                    IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),

              // logged in as
              Text(
                'You are logged in as ${currentUser.email}',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
