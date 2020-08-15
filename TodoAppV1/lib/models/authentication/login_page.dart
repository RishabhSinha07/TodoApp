import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:TodoAppV1/models/authentication/signup_page.dart';
import 'package:TodoAppV1/models/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<dynamic> _loginUser(String emailadress, String password) async {
    //var client = new http.Client();

    final response = await http.get("http://10.0.2.2:5000/api/Register",
        headers: {"emailadress": emailadress, "password": password});
    print(LoadData.fromJson(json.decode(response.body)).api_key);

    return LoadData.fromJson(json.decode(response.body)).api_key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: darkGreyColor,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Welcome!",
                      style: TextStyle(
                          color: redColor,
                          fontSize: 60,
                          fontWeight: FontWeight.bold)),
                ]),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 20),
              padding: EdgeInsets.only(left: 10),
              child: Column(children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white60,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 11.5),
                          hintText: 'Email'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white60,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 11.5),
                          hintText: 'Password'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: 130,
                    height: 50,
                    child: RaisedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      color: redColor,
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        var res = await _loginUser(
                            _emailController.text, _passwordController.text);
                        setState(() => _isLoading = false);

                        var user = res;
                        if (user != null) {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return MyHomePage(title: 'Todo App');
                          }));
                        } else
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return SignUp();
                          }));
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Text("Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 130,
                    height: 50,
                    child: RaisedButton(
                        child: Text("SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        color: redColor,
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return SignUp();
                          }));
                        }),
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}

class LoadData {
  final String api_key;
  LoadData({this.api_key});
  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(api_key: json["api_key"]);
  }
}
