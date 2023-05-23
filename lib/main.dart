import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:async';
import 'dart:convert';
import 'json_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<User>_user= [];
  Future<List<User>>fetchJson() async{
    var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/"));
    List<User> ulist = [];
    if(response.statusCode == 200){
      var urjson = json.decode(response.body);

      for(var i in urjson){
        ulist.add(User.fromJson(i));
      }
    }
    return ulist;
  }
 @override
  void initState() {
    fetchJson().then((value) {
      setState(() {
        _user.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:ListView.builder(itemBuilder: (context,index){
        return Card(
          child: Column(
            children: [
              Text(_user[index].userId.toString()),
              Text(_user[index].id.toString()),
              Text(_user[index].title.toString()),
              Text(_user[index].body.toString())
            ],
          ),
        );
      },
      itemCount: _user.length,
      )
    );
  }

}
