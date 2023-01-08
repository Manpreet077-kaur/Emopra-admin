import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/app_side_menu.dart';
import 'package:flutter_emporasports/components/header.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/screen/changepassword/change_password_presenter.dart';
import 'package:flutter_emporasports/untils/responsive.dart';
import 'package:flutter_emporasports/widget/all_widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> implements ChangePasswordInterface  {
  var isLoading = false;
  final oldPassword = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  late ChangePasswordPresenter changePasswordPresenter;

  @override
  void initState() {
    super.initState();
    changePasswordPresenter = ChangePasswordPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
      pageTitle: "Change Password",
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: HexColor("#EFF1F5"),
            child: Column(
              children: [
                Header(title: "Change Password",type:1),
                SizedBox(height: 22,),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  width:  Responsive().getResponsiveValue(
                      forLargeScreen: MediaQuery.of(context).size.width,
                      context: context),
                  child: Card(
                    color: HexColor("#FFFFFF"),
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Wrap(
                      children: [
                        Card(
                            margin: EdgeInsets.only(top: 62,left: 42,right: 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 8.0,
                            child: TextFormField(
                              controller: oldPassword,
                              cursorColor: Colors.black,
                              obscureText: true,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Old Password"),
                            )
                        ),
                        Card(
                            margin: EdgeInsets.only(top: 20,left: 42,right: 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 8.0,
                            child: TextFormField(
                              controller: password,
                              cursorColor: Colors.black,
                              obscureText: true,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "New Password"),
                            )
                        ),
                        Card(
                            margin: EdgeInsets.only(top: 20,left: 42,right: 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 8.0,
                            child: TextFormField(
                              controller: confirmPassword,
                              cursorColor: Colors.black,
                              obscureText: true,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Confirm Password"),
                            )
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              validations();
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#65A2A2"),
                              ),
                              child: Text("Submit",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AllWidgets.progressDialogs(context, isLoading)
        ],
      )

    );
  }
  validations() {
    if (oldPassword.text.toString().trim().isEmpty) {
      AllWidgets.customDialog("Enter your old password");

    }
    else if (password.text.toString().trim().isEmpty) {
      AllWidgets.customDialog("Enter your new password");
    }
    else if (password.text.toString().trim().length < 6) {
      AllWidgets.customDialog("Enter your six digit password");;
    }
    else if (confirmPassword.text.toString().trim().isEmpty) {
      AllWidgets.customDialog("Enter your confirm password");

    }
    else if (password.text.toString().trim() != confirmPassword.text.toString().trim()) {
      AllWidgets.customDialog("Confirm Password should match password");
    }
    else {
      setState(() {
        isLoading = true;
      });
      //Hide the keyBoard
      AllWidgets.keyboardHide(context);
      changePasswordPresenter.doChangePWD(oldPassword.text.toString().trim(), confirmPassword.text.toString().trim());
    }
  }


  @override
  onError(String msg, int errorCode) {
    setState(() {
      isLoading=false;
    });
    AllWidgets.customDialog(msg);
  }

  @override
  onSuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });

    oldPassword.text="";
    confirmPassword.text="";
    password.text="";

    AllWidgets.customDialog(user.message!);
  }

}
