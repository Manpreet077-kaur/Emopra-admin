import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../untils/color_utils.dart';

class AllWidgets {

  static Widget progressDialogs(BuildContext context, bool isLoading) {
    return Visibility(
        visible: isLoading,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(HexColor(AppColor.TEXT_COLOR)),
          ),
          alignment: Alignment.center,
        ));
  }
  static Widget noRecord(BuildContext context, int value) {
    bool isLoading;
    if(value==0){
      isLoading=true;
    }
    else{
      isLoading=false;
    }
    return Visibility(
        visible: isLoading,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Text("No Record Found!!",  style:TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
          alignment: Alignment.center,
        ));
  }


  static Future<bool?> customDialog(String msg){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static keyboardHide(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

}

