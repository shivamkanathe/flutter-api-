

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/main.dart';

showMessage(BuildContext context,String contentMessage){
  Widget yesButton =  FlatButton(onPressed: (){
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()), (Route<dynamic> route) => false);
  }, child: Text("Ok"));

  AlertDialog alert =  AlertDialog(
    title: Text("Message"),
    content: Text(contentMessage),
    actions: [
      yesButton
    ],
  );
  showDialog(context: context, builder:(BuildContext context){
    return alert;
  });
}