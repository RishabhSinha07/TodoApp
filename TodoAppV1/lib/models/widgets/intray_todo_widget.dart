import 'package:TodoAppV1/models/globals.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  Future deleteTitle(title) async {
    print("Here");
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api_key = prefs.getString('api_key');
    final response = http.delete("http://10.0.2.2:5000/api/task",
        headers: {'title': title, 'api_key': api_key, 'status': "not done"});
  }

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
                      deleteTitle(title);
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
