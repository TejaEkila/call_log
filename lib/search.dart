import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/components/mytextfield.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Mytextfield(
            onChanged: (s) {
              setState(() {});
            },
            Controller: searchController,
            hinttext: 'search',
          ),
        ),
        body: searchController.text.isEmpty
            ? StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Todo").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return null;
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })
            : StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Todo").snapshots(),
                builder: (context, snapshot) {
                  print(snapshot.data!.docs.length);
                  // int length = snapshot.data!.docs.length;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.docs[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase()) ||
                            snapshot.data!.docs[index]['number'].toString().contains(searchController.text)) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data!.docs[index]['name']),
                            ),
                          );
                        }
                        return Container();
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }));
  }
}
