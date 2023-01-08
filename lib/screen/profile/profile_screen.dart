import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/app_side_menu.dart';
import 'package:flutter_emporasports/model/user_details_response.dart';
import 'package:flutter_emporasports/screen/profile/profile_presenter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profile_view.dart';

class ProfileScreen extends StatefulWidget {
  String id;
  ProfileScreen(
      {Key? key,
        required this.id
      })
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> implements ProfileInterface{
  var isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ProfilePresenter viewUserPresenter;
  UserDetails? userDataList;
  @override
  void initState() {
    super.initState();
    viewUserPresenter = ProfilePresenter(this);
    setState(() {
      isLoading=true;
      viewUserPresenter.doUserDetailsAPI(widget.id.toString());
    });
  }
  Widget build(BuildContext context) {
    return AppSideMenu( pageTitle: "View User",
      body:  SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: HexColor("#EFF1F5"),
          child: Column(
            children: [
              userDataList!=null?ProfileView(userDataList:userDataList!):Container()
            ],
          ),
        )
      ),
    );
  }

  @override
  onError(int errorCode) {
   setState(() {
     isLoading=false;
   });
  }

  @override
  onUserDetailsSuccess(UserDetailResponse user) {
    setState(() {
      isLoading=false;
      userDataList=user.data!;
    });

  }
}
