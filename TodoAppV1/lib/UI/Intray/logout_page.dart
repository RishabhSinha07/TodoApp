import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:TodoAppV1/UI/Intray/timer.dart';
import 'package:TodoAppV1/models/authentication/login_page.dart';
import 'package:TodoAppV1/models/authentication/signup_page.dart';
import 'package:TodoAppV1/models/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import 'package:http/http.dart' as http;

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPage createState() => _LogoutPage();
}

class _LogoutPage extends State<LogoutPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: darkGreyColor,
      body: Column(
        children: [
          Container(
            width: 150,
            height: 50,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 2 - 75),
            child: RaisedButton(
                child: Text("Logout",
                    style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                color: Color(0xFFB5E742),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return LoginPage();
                  }));
                }),
          ),
          Container(
            width: 150,
            height: 50,
            margin: EdgeInsets.only(
                top: 40, left: MediaQuery.of(context).size.width / 2 - 75),
            child: RaisedButton(
                child: Text("Lofi",
                    style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                color: Color(0xFFB5E742),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return timer();
                  }));
                }),
          )
        ],
      ),
    );
  }
}
