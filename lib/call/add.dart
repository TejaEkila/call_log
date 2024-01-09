import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/components/mybutton.dart';
import 'package:todoapp/components/mytextfield.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(backgroundColor: Colors.amber, title: Text("Add User"), centerTitle: false, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SButtons(ontap: () {
            _savedata(_nameController.text, _numberController.text, _emailController.text);
          }),
        )
      ]),
      body: Column(
        children: [
          Gap(30),
          Mytextfield(
            Controller: _nameController,
            hinttext: 'Name', onChanged: (String ) {  },
          ),
          Gap(20),
          Mytextfield(
            Controller: _numberController,
            hinttext: 'Phone Number', onChanged: (String ) {  },
          ),
          Gap(20),
          Mytextfield(
            Controller: _emailController,
            hinttext: 'Email', onChanged: (String ) {  },
          ),
        ],
      ),
    );
  }

  void _savedata(String name, String number, String email) async {
    try {
      if (name.isEmpty && number.isEmpty && email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill All Fields")));
      } else {
        await FirebaseFirestore.instance.collection("CallData").doc(
          'Users'
        ).set({
          'name': name,
          "email": email,
          "number": number,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _nameController.clear();
        _numberController.clear();
        _emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User data is successfully stored')));

        Navigator.pop(context, {'name': name, 'number': number, 'email': email});
      }
    } catch (e) {
      print("any error in add data ${e}");
    }
  }
}
