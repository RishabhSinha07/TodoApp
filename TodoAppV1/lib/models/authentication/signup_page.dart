import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:TodoAppV1/models/authentication/login_page.dart';
import 'package:TodoAppV1/models/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _lastNameController = TextEditingController();

  TextEditingController _userNameController = TextEditingController();

  bool _isLoading = false;

  Future<dynamic> _loginUser(String emailadress, String password,
      String username, String firstname, String lastname) async {
    final response =
        await http.post("http://10.0.2.2:5000/api/Register", headers: {
      "emailadress": emailadress,
      "password": password,
      "username": username,
      "firstname": firstname,
      "lastname": lastname
    });
    print(LoadData.fromJson(json.decode(response.body)).user_created);

    return LoadData.fromJson(json.decode(response.body)).user_created;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: darkGreyColor,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 50),
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("SignUp", style: intraTitleStyle),
                ]),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: EdgeInsets.only(left: 10),
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: redColor),
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      hintText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      hintText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      hintText: 'First Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      hintText: 'Last Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      hintText: 'Username',
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("SignUp"),
                  color: redColor,
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    var res = await _loginUser(
                        _emailController.text,
                        _passwordController.text,
                        _firstNameController.text,
                        _lastNameController.text,
                        _userNameController.text);
                    setState(() => _isLoading = false);

                    var user = res;
                    if (user != null) {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return LoginPage();
                      }));
                    } else
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return SignUp();
                      }));
                  },
                )
              ]))
        ],
      ),
    );
  }
}

class LoadData {
  final String user_created;
  LoadData({this.user_created});
  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(user_created: json["user_created"]);
  }
}
