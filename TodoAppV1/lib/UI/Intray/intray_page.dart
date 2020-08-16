import 'dart:convert';

import 'package:TodoAppV1/models/classes/task.dart';
import 'package:TodoAppV1/models/globals.dart';
import 'package:TodoAppV1/models/widgets/intray_todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<IntrayTodo> _list = [];
  @override
  // ignore: override_on_non_overriding_member
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      IntrayTodo row = _list.removeAt(oldIndex);
      _list.insert(newIndex, row);
    });
  }

  Widget build(BuildContext context) {
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();
    return Container(
      child: FutureBuilder(
          future: _getTask(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  color: darkGreyColor,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: darkGreyColor,
                        expandedHeight: 280.0,
                      ),
                      ReorderableSliverList(
                        delegate:
                            ReorderableSliverChildListDelegate(getList([])),
                        onReorder: _onReorder,
                      )
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return Container(
                  color: darkGreyColor,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: darkGreyColor,
                        expandedHeight: 280.0,
                      ),
                      ReorderableSliverList(
                        delegate:
                            ReorderableSliverChildListDelegate(getList([])),
                        onReorder: _onReorder,
                      )
                    ],
                  ),
                );
              case ConnectionState.active:
                return Container(
                  color: darkGreyColor,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: darkGreyColor,
                        expandedHeight: 280.0,
                      ),
                      ReorderableSliverList(
                        delegate:
                            ReorderableSliverChildListDelegate(getList([])),
                        onReorder: _onReorder,
                      )
                    ],
                  ),
                );
              case ConnectionState.done:
                return Container(
                  color: darkGreyColor,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: darkGreyColor,
                        expandedHeight: 280.0,
                      ),
                      ReorderableSliverList(
                        delegate: ReorderableSliverChildListDelegate(
                            getList(snapshot.data)),
                        onReorder: _onReorder,
                      )
                    ],
                  ),
                );
            }
          }),
    );
  }

  List<Widget> getList(data) {
    _list = [];
    for (int i = 0; i < data.length; i++) {
      Task temp = Task(data[i], false, i.toString());
      _list.add(IntrayTodo(title: temp.title));
    }
    return _list;
  }

  Future _getTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get("http://10.0.2.2:5000/api/task",
        headers: {"api_key": prefs.getString('api_key')});

    return LoadData.fromJson(json.decode(response.body)).data;
  }
}

class LoadData {
  var data;
  LoadData({this.data});
  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(data: json["task"]);
  }
}
