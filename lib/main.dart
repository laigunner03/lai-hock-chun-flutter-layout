import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {


  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List _items =[];

  final String defaultimage = "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";

@override
  void initState() {

    readJson();
  }

Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/mock_data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
      print(_items[0]['username']);
    });
  }



  @override
  Widget build(BuildContext context) {
    
    // String fName ="James";
    // String lName = "Brigs";
    // String username = "james1996";
    // String status ="Online";
    // String lastseen = "9.30AM";
    
    // int messageLeft = 4;

    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: SafeArea(
            child: ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.all(1),
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
               child: _items[index]["avatar"] == null ? Image.network(defaultimage, fit:BoxFit.fill) : Image(image: _items[index]["avatar"], fit:BoxFit.fill),
              ),
              SizedBox(width: 5),
              Container(  
                
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    Container(
                      child: 
                          Row(
                            children: [
                              Container(
                                child: Text(_items[index]["first_name"], style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                child: Text(" ")
                              ),
                              Container(
                                child: Text(_items[index]["last_name"], style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ],
                          )
                      
                    ),
                    Container(
                      child: Text(_items[index]["username"], style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: Text(_items[index]["status"], style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
              SizedBox(width: 100),
              Container(
                 
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      padding: EdgeInsets.all(4),
                     child: Text(_items[index]["last_seen_time"])
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: _items[index]["messages"] == null ? Text("") : Text("${_items[index]["messages"]}", style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ]
                
                )
              ),

            
            ],
          ),
          
          
          color: Colors.grey[400],
        );
      },
    ))
      
    );
  }
}
