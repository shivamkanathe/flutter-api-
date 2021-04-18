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

  bool isLoading = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  Future updateStudent(String name, String schoolName, int contactNumber, int age, String studentId) async {
    var url =
        "https://fierce-citadel-10341.herokuapp.com/updateStudentById/$studentId";
    var bodyData = json.encode({
      "name": name,
      "schoolName": schoolName,
      "contactNumber": contactNumber,
      "age": age,
      "_id": studentId,
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
  void initState() {
    // TODO: implement initState
    getStudent();
  }

  getStudent()async{
    setState(() {
      isLoading = true;
    });
    Student myDetail =  await (widget.mydata);
    userNameController.text =  myDetail.studentName.toString();
    schoolNameController.text =  myDetail.schoolName.toString();
    contactNumberController.text =  myDetail.contactNumber.toString();
    agecontroller.text =  myDetail.age.toString();
    setState(() {
      isLoading =  false;
    });
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

              InkWell(
                onTap: (){
                  setState(() {
                    updateStudent(
                                  userNameController.text == widget.mydata.studentName ? widget.mydata.studentName : userNameController.text.toString(),
                                  schoolNameController.text == widget.mydata.schoolName ?widget.mydata.schoolName : schoolNameController.text.toString(),
                                  (int.parse(contactNumberController.text == widget.mydata.contactNumber ? widget.mydata.contactNumber : contactNumberController.text)),
                                  (int.parse(agecontroller.text == widget.mydata.age ? widget.mydata.age : agecontroller.text)),
                                  widget.mydata.id);
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
                  child: Text("Update", textAlign:TextAlign.center ,style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),

            ],
          )),
    );
  }
}
