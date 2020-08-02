import 'package:TodoAppV1/models/globals.dart';
import 'package:flutter/material.dart';

class IntrayTodo extends StatelessWidget {
  final String title;
  IntrayTodo({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: redColor,
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Radio(),
          Column(
            children: <Widget>[
              Text(
                title,
                style: darkTodoTitleStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
