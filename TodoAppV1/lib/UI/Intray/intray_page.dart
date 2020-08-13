import 'package:TodoAppV1/models/classes/task.dart';
import 'package:TodoAppV1/models/globals.dart';
import 'package:TodoAppV1/models/widgets/intray_todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

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
      color: darkGreyColor,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: darkGreyColor,
            expandedHeight: 280.0,
          ),
          ReorderableSliverList(
            delegate: ReorderableSliverChildListDelegate(getList()),
            onReorder: _onReorder,
          )
        ],
      ),
    );
  }

  List<Widget> getList() {
    for (int i = 0; i <= 20; i++) {
      Task temp = Task("My first todo" + i.toString(), false, i.toString());
      _list.add(IntrayTodo(title: temp.title));
    }
    return _list;
  }
}
