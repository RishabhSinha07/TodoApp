import 'package:TodoAppV1/models/globals.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IntrayTodo extends StatefulWidget {
  String title;
  String status;
  IntrayTodo({this.title, this.status});
  @override
  _IntrayTodo createState() => _IntrayTodo(title, status);
}

class _IntrayTodo extends State<IntrayTodo> {
  String title;
  String status;
  _IntrayTodo(this.title, this.status);
  Color cardColor = redColor;
  String _animationName = 'Off';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: cardColor,
          boxShadow: [
            new BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_animationName == 'Off') {
                      _animationName = 'On';
                      cardColor = Color(0xFFB5E742);
                    } else {
                      _animationName = 'Off';
                      cardColor = redColor;
                    }
                  });
                },
                child: FlareActor(
                  'assets/Smiley Switch.flr',
                  animation: _animationName,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              title,
              style: darkTodoTitleStyle,
            )
          ],
        ));
  }
}
