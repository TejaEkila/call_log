// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables


import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final Controller;
  final String hinttext;
  final Function(String)? onChanged;
   Mytextfield({
    super.key,
    required this.Controller,
    required this.hinttext,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50,
        child: TextField(
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          controller: Controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(160, 254, 185, 1))),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0))),
            fillColor: Color.fromARGB(26, 144, 62, 62),
            filled: true,
            hintText: hinttext,
            hintStyle: TextStyle(color: const Color.fromARGB(255, 9, 0, 0)),
            prefixIcon: Icon(Icons.search)
          ),
        ),
      ),
    );
  }

  
}
