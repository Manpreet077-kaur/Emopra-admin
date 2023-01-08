import 'package:flutter/material.dart';
import 'package:flutter_emporasports/route/route_name.dart';
import 'package:flutter_emporasports/untils/sharedpref/shared_prefrence.dart';
import 'package:hexcolor/hexcolor.dart';
import '../untils/constants.dart';
import '../untils/sharedpref/preferences.dart';

class Header extends StatelessWidget {
  final String title;
  final int type;
  const Header({
    Key? key,
    required this.title,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 12,right: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color:Colors.black),
          ),
          Spacer(flex: 2),
          type!=0?Container(padding: EdgeInsets.all(26),):ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return GestureDetector(
      onTap: (){
        // Navigator.pushNamed(context, RouteNames.profile);
      },
      child: Container(
        margin: EdgeInsets.only(left: Constants.defaultPadding),
        padding: EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding * 0.5
        ),
        child: Row(
          children: [
            Icon(Icons.perm_identity_sharp,size: 30,color: HexColor("#65A2A2"),),
            /*Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding * 0.5),
              child: Text(SessionManager.getString(Preferences.FIRST_NAME).toString()+" "+SessionManager.getString(Preferences.LAST_NAME),style: TextStyle(color: HexColor("#65A2A2")),),
            ),
          ],
        ),
      ),
    );
  }
}

