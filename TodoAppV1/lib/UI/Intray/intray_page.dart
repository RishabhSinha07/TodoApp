import 'package:TodoAppV1/models/globals.dart';
import 'package:TodoAppV1/models/widgets/intray_todo_widget.dart';
import 'package:flutter/material.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      child: ListView(
        padding: EdgeInsets.only(top: 280),
        children: getList(),
      ),
    );
  }

  List<Widget> getList() {
    List<IntrayTodo> li = [];
    for (int i = 0; i <= 10; i++) {
      li.add(IntrayTodo(title: "Hello"));
    }
    return li;
  }
}
