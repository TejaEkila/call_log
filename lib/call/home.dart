import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/call/add.dart';

//import 'package:todoapp/call/editpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Home Page"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () async {
                Map<String, String>? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUser()),
                );

                // Check if data is not null and add it to the list
                if (result != null) {
                  setState(() {
                    userList.add(result);
                  });
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          // Display user list
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Todo").where("name", isEqualTo: "mothu").snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data!.docs[index]["name"]),
                      subtitle: Text(snapshot.data!.docs[index]["number"]),
                      onTap: () async {
                        // Navigate to EditUser screen and pass initial data
                        // Map<String, String>? result = await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EditUser(
                        //       initialName: userList[index]['name'] ?? '',
                        //       initialNumber: userList[index]['number'] ?? '',
                        //       initialEmail: userList[index]['email'] ?? '',
                        //     ),
                        //   ),
                        // );

                        // Check if data is not null and update it in the list
                        // if (result != null) {
                        //   setState(() {
                        //     userList[index] = result;
                        //   });
                        // }
                      },
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
