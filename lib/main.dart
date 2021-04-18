import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AddEditStudent.dart';
import 'package:test1/EditStudent.dart';
import 'package:test1/StudentDetailPage.dart';
import 'package:test1/Util.dart';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // Future <List<Student>> futureData;

  final String url =
      "https://fierce-citadel-10341.herokuapp.com/getAllStudents";

  List<Student> myAllData = [];

  Future<Student> futureData;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future loadStudents() async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      for (var data in jsonBody) {
        myAllData.add(Student(
            studentName: data['name'],
            id: data['_id'],
            schoolName: data['schoolName'],
            contactNumber: data['contactNumber'],
            age: data['age']));
      }
      setState(() {});
      myAllData.forEach((element) => print("Name :-  ${element.studentName}"));
    } else {
      print("some thing went wrong");
    }
  }

  Future deleteStudent(String studentId) async {
    final http.Response response = await http.delete(
      Uri.parse(
          'https://fierce-citadel-10341.herokuapp.com/deleteStudentById/$studentId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }

  // Future<Null>_onRefresh() {
  //   Completer<Null> completer = new Completer<Null>();
  //   Timer timer = new Timer(new Duration(seconds: 3), () {
  //     completer.complete();
  //   });
  //   return completer.future;
  // }

  // Future<void> _onRefresh() async {
  //   refreshKey.currentState?.show(atTop: false);
  //   await Future.delayed(Duration(seconds: 2));
  //     loadStudents();
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Management System"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEditStudent()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: myAllData.length != 0
            ? RefreshIndicator(
            onRefresh:()=> Future.delayed(const Duration(seconds: 3)),
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: myAllData.length,
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StudentDetailPage(mydata: myAllData[i])));
                      },
                      child: Card(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myAllData[i].studentName,
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500)),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditStudent(
                                                        mydata: myAllData[i],
                                                      )));
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          var message =
                                              "Are you sure want to delete student?";
                                          showMessage(context, message);
                                          setState(() {
                                            deleteStudent(
                                                myAllData[i].id.toString());
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
