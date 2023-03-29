import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customtoast(
  String msg,Color backgroundColor
){
  Fluttertoast.showToast(

        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:backgroundColor ,
        
        textColor: Colors.white,
        fontSize: 16.0
    );
}