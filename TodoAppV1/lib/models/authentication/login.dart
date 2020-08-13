import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import 'package:http/http.dart' as http;

class LoginWithRestfulApi extends StatefulWidget {
  @override
  _LoginWithRestfulApiState createState() => _LoginWithRestfulApiState();
}

class _LoginWithRestfulApiState extends State<LoginWithRestfulApi> {
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
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Login"),
                    color: Colors.red,
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
                          return LoginWithRestfulApi();
                        }));
                    },
                  ),
                ],
              ),
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
