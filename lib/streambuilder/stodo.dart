import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/search.dart';

class STodo extends StatefulWidget {
  const STodo({super.key});

  @override
  State<STodo> createState() => _STodoState();
}

class _STodoState extends State<STodo> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Call Log",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
              },
              icon: Icon(
                Icons.search,
                size: 30,
                weight: 400,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: name,
                                decoration: InputDecoration(hintText: "Name"),
                              ),
                              TextField(
                                controller: number,
                                decoration: InputDecoration(hintText: "Number"),
                              ),
                              Gap(30),
                              GestureDetector(
                                onTap: () async {
                                  if (name.text.isEmpty && number.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill All Fields")));
                                  } else {
                                    await FirebaseFirestore.instance.collection("Todo").doc().set({"name": name.text, "number": number.text, "DateTime": DateTime.now(),"request":"pending"}).then((value) {
                                      Navigator.pop(context);
                                      name.clear();
                                      number.clear();
                                      setState(() {});
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blueGrey,
                                  ),
                                  child: Center(child: Text('Add')),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.add,
                size: 30,
                weight: 400,
              ))
        ],
      ),
      backgroundColor: Colors.amber,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Todo").where("name", isNotEqualTo: "mothu").snapshots(),
          // stream: FirebaseFirestore.instance.collection("Todo").limit(2).snapshots(),
          // stream: FirebaseFirestore.instance.collection("Todo").orderBy("DateTime", descending: false).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int T = snapshot.data!.docs.length;
              return ListView.builder(
                itemCount: T,
                itemBuilder: (context, index) {
                  var datas = snapshot.data!.docs[index];
                  //DateTime dt = datas['DateTime'].toDate();

                  return ListTile(
                    onTap: () async {
                      TextEditingController editName = TextEditingController(text: datas['name']);
                      TextEditingController editNumber = TextEditingController(text: datas['number']);

                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      controller: editName,
                                      decoration: InputDecoration(hintText: "Name"),
                                    ),
                                    TextField(
                                      controller: editNumber,
                                      decoration: InputDecoration(hintText: "Number"),
                                    ),
                                    Gap(30),
                                    GestureDetector(
                                      onTap: () async {
                                        if (editName.text.isEmpty && editNumber.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill All Fields")));
                                        } else {
                                          await FirebaseFirestore.instance.collection("Todo").doc(datas.id).update({"name": editName.text, "number": editNumber.text}).then((value) {
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.blueGrey,
                                        ),
                                        child: Center(child: Text('Update')),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    title: Text(
                      datas['name'],
                    ),
                    leading: CircleAvatar(
                        // child: Text(name[index][0].toString()),
                        ),
                    subtitle: Text(datas['number']),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.call,
                          size: 25,
                        )),
                  );
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
