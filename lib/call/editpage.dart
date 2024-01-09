import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:todoapp/components/mytextfield.dart';

class EditUser extends StatefulWidget {
  final String initialName;
  final String initialNumber;
  final String initialEmail;

  EditUser({
    required this.initialName,
    required this.initialNumber,
    required this.initialEmail,
  });

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _numberController.text = widget.initialNumber;
    _emailController.text = widget.initialEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("Edit User"),
      ),
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
          ElevatedButton(
            onPressed: () {
              _updateUserData();
            },
            child: Text("Update User"),
          ),
        ],
      ),
    );
  }

  void _updateUserData() async {
    try {
      // Check if any field is empty
      if (_nameController.text.isEmpty ||
          _numberController.text.isEmpty ||
          _emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fill All Fields")),
        );
      } else {
        // Create a result map to pass back to the previous screen
      await FirebaseFirestore.instance.collection("CallData").doc().update({
        'name': _nameController.text,
          'number': _numberController.text,
          'email': _emailController.text,
      });
        

        // Pop the screen and pass the result back
        Navigator.pop(context,);
      }
    } catch (e) {
      print("Error updating user data: $e");
    }
  }
}
