import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AddEditStudent.dart';
import 'package:test1/StudentDetailPage.dart';
import 'package:test1/studentModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


Future<List<Student>> fetchStudent() async {

  final response = await http.get(Uri.parse("https://fierce-citadel-10341.herokuapp.com/getAllStudents"));

  if (response.statusCode == 200) {
     List jsonResponse =  json.decode(response.body);
     return jsonResponse.map((data) => Student.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load post');
  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future <List<Student>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchStudent();
  }
  @override
  Widget build(BuildContext context) {
  print("ok");
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Management System"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddEditStudent()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child:FutureBuilder<List<Student>>(
            future: futureData,
          builder:(context,snapshot){
            if(snapshot.hasData){
              List<Student> data = snapshot.data;
              // print("this is data ${snapshot.data}");
              return ListView.builder(
                itemCount:data.length,
                itemBuilder:(c,i){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentDetailPage(mydata: data[i],)));
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical:10,horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[i].studentName.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)
                            ),

                            Container(
                              child: Row(
                                children: [
                                  IconButton(icon: Icon(Icons.edit,color: Colors.blue,), onPressed:(){}),
                                  IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed:(){}),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
            }
            else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }
        )
      ),
    );
  }
}
