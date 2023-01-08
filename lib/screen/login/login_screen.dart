import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/model/login_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/screen/login/login_presenter.dart';
import 'package:flutter_emporasports/untils/responsive.dart';
import 'package:flutter_emporasports/untils/sharedpref/preferences.dart';
import 'package:flutter_emporasports/untils/sharedpref/shared_prefrence.dart';
import 'package:flutter_emporasports/widget/all_widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../untils/string_utils.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements ApiLoginInterface  {
var isLoading = false;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController forgotPasswordController = TextEditingController();
late LoginPresenter loginPresenter;

@override
void initState() {
  super.initState();
  loginPresenter = LoginPresenter(this);
}
Future<bool> _onWillPop() async {
  return false; //<-- SEE HERE
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: HexColor("#EBEDEF"),
                child:Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    width:  Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width/3,
                        context: context),
                    child: Card(
                      color: HexColor("#FFFFFF"),
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Wrap(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40,bottom: 10.0),
                            child: Center(
                              child: Image.asset("assets/images/logo.png",height: 30,color: Colors.black,
                                width: MediaQuery.of(context).size.width/3,),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child:
                            Text("Log in to your account",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                          ),
                          Card(
                              margin: EdgeInsets.only(top: 22,left: 42,right: 42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 8.0,
                              child: TextFormField(
                                controller: emailController,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                    hintText: "Email"),
                              )
                          ),
                          Card(
                              margin: EdgeInsets.only(top: 20,left: 42,right: 42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 8.0,
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                    hintText: "Password"),
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showAlertForgotDialog(context);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 46,top: 10),
                                    child: Text("Forgot Password?",style: TextStyle(color: Colors.black),)),
                              )
                            ],
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: (){
                               validation();
                              },
                              child: Container(
                                width: 120,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor("#65A2A2"),
                                ),
                                child: Text("LOGIN",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
            AllWidgets.progressDialogs(context, isLoading)
          ],
        ),
      ),
    );
  }

  showAlertForgotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          actions: [
             Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    width:  Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width/3.6,
                        context: context),
               height:  Responsive().getResponsiveValue(
                   forLargeScreen: MediaQuery.of(context).size.height/2,
                   context: context),
                      child: Wrap(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40,bottom: 10.0),
                            child: Center(
                              child: Image.asset("assets/images/logo.png",height: 30,color: Colors.black,
                                width: MediaQuery.of(context).size.width/3,),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child:
                            Text("Forgot Password",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                          ),
                          Card(
                              margin: EdgeInsets.only(top: 22,left: 32,right: 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 8.0,
                              child: TextFormField(
                                controller: forgotPasswordController,
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                    hintText: "Email"),
                              )
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: (){
                                if(forgotPasswordController.text.toString()==""){
                                  AllWidgets.customDialog(UtilStrings.enteremail);
                                }
                                else{
                                  setState(() {
                                    isLoading=true;
                                  });
                                  loginPresenter.doForgotPassword(forgotPasswordController.text.toString());
                                   }
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
                    )
          ],
        );;
      },
    );
  }

  void validation() {
    if (emailController.text.isEmpty) {
     AllWidgets.customDialog(UtilStrings.enteremail);
    }
    else if (!EmailValidator.validate(emailController.text.toString().trim())) {
      AllWidgets.customDialog(UtilStrings.entervalidemail);
    }
    else if (passwordController.text.isEmpty) {
      AllWidgets.customDialog(UtilStrings.enterPassword);
    }
    else{
      setState(() {
        isLoading=true;
      });
     loginPresenter.doLogin(emailController.text.toString(), passwordController.text.toString());
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
  onSuccess(LoginResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.statusCode==200){
      SessionManager.setString(Preferences.ACCESS_TOKEN, user.data!.token!);
      SessionManager.setString(Preferences.FIRST_NAME, user.data!.firstName!);
      SessionManager.setString(Preferences.LAST_NAME, user.data!.lastName!);
      SessionManager.setString(Preferences.EMAIL, user.data!.email!);
      SessionManager.setBoolean(Preferences.IS_USER_LOGIN, true);
      AllWidgets.customDialog(user.message!);
      // MainScreen
      Navigator.push(context, MaterialPageRoute(builder:(context)=>DashboardScreen()));
    }
    else{
      AllWidgets.customDialog(user.message!);
    }
  }

  @override
  onForgotSuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.statusCode==200){
      Navigator.pop(context);
      forgotPasswordController.text="";
    }
    else{
      AllWidgets.customDialog(user.message!);
    }
  }
}
