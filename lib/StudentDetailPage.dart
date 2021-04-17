import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/studentModel.dart';

class StudentDetailPage extends StatefulWidget {
  final Student mydata;
  StudentDetailPage({this.mydata});

  @override
  _StudentDetailPageState createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.mydata.studentName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ),
      body: Container(
        color: Color(0xffF9F9F9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    "Student Name :-",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )),
                  Expanded(
                      child: Text(
                    widget.mydata.studentName.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text("School Name :-",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                  Expanded(
                      child: Text(widget.mydata.schoolName.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text("Contact Number :-",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                  Expanded(
                      child: Text(widget.mydata.contactNumber.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text("Age :-",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                  Expanded(
                      child: Text(widget.mydata.age.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
