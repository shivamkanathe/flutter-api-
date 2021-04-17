import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test1/Util.dart';
import 'package:test1/studentModel.dart';

class EditStudent extends StatefulWidget {
  final Student mydata;
  EditStudent({this.mydata});
  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  Future updateStudent(String name, String schoolName, int contactNumber,
      int age, String studentId) async {
    var url =
        "https://fierce-citadel-10341.herokuapp.com/updateStudentById/$studentId";
    var bodyData = json.encode({
      "name": name,
      "schoolName": schoolName,
      "contactNumber": contactNumber,
      "age": age,
    });

    var response = await http.patch(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: bodyData);
    if (response.statusCode == 200) {
      var message = "Student updated successfully ";
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
        title: Text("Edit Student"),
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
                  hintText: "${widget.mydata.studentName}",
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
                  hintText: "${widget.mydata.schoolName}",
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
                  hintText: "${widget.mydata.contactNumber}",
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
                  hintText: "${widget.mydata.age}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.deepPurple,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: MaterialButton(
                    onPressed: () {
                       setState(() {
                         updateStudent(
                             userNameController.text,
                             schoolNameController.text,
                             (int.parse(contactNumberController.text)),
                             (int.parse(agecontroller.text)),
                             widget.mydata.id);
                       });
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ))
            ],
          )),
    );
  }
}
