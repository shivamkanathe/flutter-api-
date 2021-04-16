
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test1/studentModel.dart';



// Future<Student> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.https('jsonplaceholder.typicode.com', 'albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//
//   if (response.statusCode == 201) {
//     return Student.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to create album.');
//   }
//}




class AddEditStudent extends StatefulWidget {
  @override
  _AddEditStudentState createState() => _AddEditStudentState();
}

class _AddEditStudentState extends State<AddEditStudent> {


  Future<List<Student>> addStudent(String name, String schoolName,int age, int contactNumber) async {
    final response = await http.post(
        Uri.parse("https://fierce-citadel-10341.herokuapp.com/postStudentDetail"),
      //  headers: {"Content-Type": "application/json"},
        body: {
          'name': userNameController.text,
          'schoolName':schoolNameController.text,
          "age":ageController.text,
          "contactNumber":contactNumberController.text
        });

    if (response.statusCode == 201) {
      List jsonResponse =  json.decode(response.body);
      return jsonResponse.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Failed to create album.');
    }
  }


  Future <List<Student>> futureData;
  TextEditingController userNameController =  TextEditingController();
      TextEditingController schoolNameController =  TextEditingController();
      TextEditingController contactNumberController = TextEditingController();
      TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("work data post ${futureData}");
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
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: schoolNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                hintText: "Enter schoolName",
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: contactNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter contactNumber",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(
                        color: Colors.grey
                    )
                ),
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              keyboardType: TextInputType.number,
              controller: ageController,
              decoration: InputDecoration(
                hintText: "Enter student age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.deepPurple,
                ),
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 5),
                child: MaterialButton(onPressed: (){
                  setState(() {
                    print("this is my post datakkkk ${futureData}");
                    futureData = addStudent(userNameController.text, schoolNameController.text,(int.parse(ageController.text)) ,(int.parse(contactNumberController.text)));

                  });
                  print("final print ${futureData}");
                }, child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 20),), ))
          ],
        )
      ),
    );
  }
}
