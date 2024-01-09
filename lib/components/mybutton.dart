// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class SButtons extends StatelessWidget {
  final ontap;

  const SButtons({super.key,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40,
        width: 100,
        
      
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
          ),
        ),
      ),
    );
  }
}
