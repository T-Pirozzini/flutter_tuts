import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_social_app/components/text_box.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    // edit field
    Future<void> editField(String field) async {}

    return Scaffold(
      appBar: AppBar(
        title: const Text('P R O F I L E'),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          // profile pic
          const Icon(
            Icons.person,
            size: 72,
          ),

          const SizedBox(height: 50),

          // user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),

          const SizedBox(height: 50),

          // user details
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // username
          MyTextBox(
            text: 'my name',
            sectionName: 'username',
            onPressed: () => editField('username'),
          ),

          const SizedBox(height: 10),

          // bio
          MyTextBox(
            text: 'empty bio',
            sectionName: 'bio',
            onPressed: () => editField('bio'),
          ),

          const SizedBox(height: 50),

          // user posts
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Posts',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
