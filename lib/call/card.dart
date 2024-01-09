import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('CallData').doc('Users').snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Center(
              child: Text('No data available.'),
            );
          }

          var userData = snapshot.data!.data()!;

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              var user = userData[index];
              return ListTile(
                leading: CircleAvatar(),
                title: Text('Name: ${user['name']}'),
                trailing: Icon(Icons.call,size: 30,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${user['email']}'),
                    Text('Number: ${user['number']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
