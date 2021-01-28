import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Day 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> _toDoList = [ToDo('To do 1')];

  TextEditingController _toDoTextEditController = TextEditingController();

  void _addToDoList(String todoName) {
    setState(() {
      _toDoList.add(ToDo(todoName));
      _toDoTextEditController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: ListView(children: _getItems())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _showDialog(),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _showDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 16,
      child: Container(
          padding: EdgeInsets.all(10.0),
          height: 210,
          width: 400,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Add new task',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: "Enter Task",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          controller: _toDoTextEditController,
                        )),
                  ])),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side:
                            BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                    onPressed: () {
                      _addToDoList(_toDoTextEditController.text);
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.all(10.0),
                    color: Color.fromRGBO(0, 160, 227, 1),
                    textColor: Colors.white,
                    child: Text("Add", style: TextStyle(fontSize: 15)),
                  ))
            ],
          )),
    );
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (ToDo toDo in _toDoList) {
      _todoWidgets.add(_buildTodoItem(toDo));
    }
    return _todoWidgets;
  }

  Widget _buildTodoItem(ToDo toDo) {
    return Container(
        //padding:
        //    EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: CheckboxListTile(
          title: Text(toDo.name),
          value: toDo.isDone,
          onChanged: (newValue) {
            setState(() {
              toDo.isDone = newValue;
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ));
  }
}

class ToDo {
  bool isDone = false;
  String name = "";

  ToDo(this.name);
}
