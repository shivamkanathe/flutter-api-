import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test1/Util.dart';
import 'package:test1/studentModel.dart';

class AddEditStudent extends StatefulWidget {
  @override
  _AddEditStudentState createState() => _AddEditStudentState();
}

class _AddEditStudentState extends State<AddEditStudent> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();


  Future addStudent( String name, String schoolName, int contactNumber, int age) async {
    var url = "https://fierce-citadel-10341.herokuapp.com/postStudentDetail";
    var bodyData = json.encode({
      "name": name,
      "schoolName": schoolName,
      "contactNumber": contactNumber,
      "age": age,
    });

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: bodyData);
    if (response.statusCode == 200){
      var message = "Data uploaded successfully ";

      showMessage(context, message);
      setState(() {
        userNameController.text = "";
        schoolNameController.text = "";
        contactNumberController.text = "";
        agecontroller.text = "";
      });
      return Student.fromJson(jsonDecode(response.body));
    } else {
      var messageError = "Can not add student";
      showMessage(context, messageError);
      throw Exception("Something gone wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("work data post ${futureData}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
        centerTitle: true,
      ),
      body: Container(
          color: Color(0xffF9F9F9),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Enter student name",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: schoolNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Enter schoolName",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: contactNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter contactNumber",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: agecontroller,
                decoration: InputDecoration(
                  hintText: "Enter student age",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),

              InkWell(
                onTap: (){
                  setState(() {
                    addStudent(
                        userNameController.text,
                        schoolNameController.text,
                        (int.parse(contactNumberController.text)),
                        (int.parse(agecontroller.text)));
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width/6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Add", textAlign:TextAlign.center ,style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
            ],
          )),
    );
  }
}
