import 'package:flutter/material.dart';
import 'package:restaurant_app/constants.dart';

const kSendButtonTextStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
    border: Border(
        top: BorderSide(color: kRedColor, width: 2.0),
    ),
);
const kTextFileDecoration = InputDecoration(
    hintText: 'Enter your password.',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kGreenColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kGreenColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
);
const kRedColor=Color(0xfffa163f);
const kCardColor=Color(0xFF12cad6);