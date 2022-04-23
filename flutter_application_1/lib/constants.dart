import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  //appBarDecoration = appBar: AppBar(),

  fillColor: Colors.white,

  filled: true,
  //focusColor: Color.fromARGB(255, 71, 66, 66),
  //hoverColor: Color.fromARGB(255, 71, 66, 66),
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF500000), width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 234, 195, 18), width: 2.0),
  ),
);
