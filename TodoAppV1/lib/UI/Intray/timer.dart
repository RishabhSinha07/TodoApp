import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class timer extends StatefulWidget {
  @override
  _timer createState() => _timer();
}

class _timer extends State<timer> with FlareController {
  List<Color> exampleColors = <Color>[Colors.red, Colors.green, Colors.blue];
  FlutterColorFill _fill;
  void initialize(FlutterActorArtboard artboard) {
    // Find our "Num 2" shape and get its fill so we can change it programmatically.
    FlutterActorShape shape = artboard.getNode("Num 2");
    _fill = shape?.fill as FlutterColorFill;
  }

  void setViewTransform(Mat2D viewTransform) {}

  bool advance(FlutterActorArtboard artboard, double elapsed) {
    // advance is called whenever the flare artboard is about to update (before it draws).
    Color nextColor = exampleColors[_counter % exampleColors.length];
    if (_fill != null) {
      _fill.uiColor = nextColor;
    }
    // Return false as we don't need to be called again. You'd return true if you wanted to manually animate some property.
    return false;
  }

  // We're going to use the counter to iterate the color.
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: FlareActor("assets/Day-night.flr",
          fit: BoxFit.cover,
          alignment: Alignment.center,
          animation: 'Run',
          controller: this),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
