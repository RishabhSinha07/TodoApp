import 'package:TodoAppV1/UI/Intray/intray_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/globals.dart';
import 'UI/Intray/logout_page.dart';
import 'models/authentication/login_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      //home: MyHomePage(title: 'Todo App'),
      home: FutureBuilder(
        future: getUser(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return Text('Result: ${snapshot.data}');
          }
          return null; // unreachable
        },
      ),
    );
  }
}

Future getUser() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api_key = prefs.getString('api_key');
  print(api_key);
  runApp(MaterialApp(
      home: api_key == null ? LoginPage() : MyHomePage(title: 'Todo App')));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  TextEditingController _task = TextEditingController();

  Future<dynamic> _updateTable(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //var client = new http.Client();

    final response = await http.post("http://10.0.2.2:5000/api/task", headers: {
      "api_key": prefs.getString('api_key'),
      "task": task,
      "status": "not_done"
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(),
                  LogoutPage(),
                  new Container(
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: 50),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Intray", style: intraTitleStyle),
                      Container()
                    ],
                  )),
              Container(
                height: 85,
                width: 85,
                margin: EdgeInsets.only(
                    top: 110,
                    left: MediaQuery.of(context).size.width * 0.5 - 85 * 0.5),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 50,
                  ),
                  backgroundColor: redColor,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              insetPadding: EdgeInsets.only(
                                  top: 120, left: 10, right: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 16,
                              child: Container(
                                  color: Color(0xFFC7A1A1),
                                  height: 250,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "New Task",
                                        style: TextStyle(
                                            color: darkGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Container(
                                        height: 130,
                                        margin: EdgeInsets.only(
                                            top: 35, left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Color(0xFFD3D3D3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            style:
                                                TextStyle(color: darkGreyColor),
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            expands: false,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textAlign: TextAlign.center,
                                            controller: _task,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Tell me the new task!',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: RaisedButton(
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              color: redColor,
                                              onPressed: () async {
                                                setState(
                                                    () => _isLoading = true);
                                                var res = await _updateTable(
                                                    _task.text);
                                                setState(
                                                    () => _isLoading = false);

                                                var user = res;
                                                if (user != null) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute<Null>(
                                                          builder: (BuildContext
                                                              context) {
                                                    return MyHomePage(
                                                        title: 'Todo App');
                                                  }));
                                                }
                                              }))
                                    ],
                                  )));
                        });
                  },
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.brown,
          ),
        ),
      ),
    );
  }
}
