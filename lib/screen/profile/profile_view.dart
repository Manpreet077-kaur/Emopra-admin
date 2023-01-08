import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/header.dart';
import 'package:flutter_emporasports/model/user_details_response.dart';
import 'package:flutter_emporasports/untils/constants.dart';
import 'package:flutter_emporasports/untils/responsive.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileView extends StatelessWidget {
  UserDetails userDataList;
  ProfileView(
      { Key? key,
        required this.userDataList
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Container(
      child: Column(children: [
          Header(title: "Profile",type:1),
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
                  child: Container(
                    padding: EdgeInsets.all(22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                child: ClipOval(
                                    child:Image.network(Constants.USER_IMAGE_URL+userDataList.profilePicture.toString(),
                                      errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace){
                                return  Icon(Icons.perm_identity_sharp,size: 20,color: HexColor("#65A2A2"),);
                                },)))
                          ],
                        ),
                        !displayMobileLayout? SizedBox(
                          width: 50,
                        ):SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name"),
                            SizedBox(height: 14,),
                            Text("Email"),
                            SizedBox(height: 14,),
                            Text("Phone"),
                            SizedBox(height: 14,),
                            /*Text("Role"),
                            SizedBox(height: 14,),
                            Text("Country"),
                            SizedBox(height: 14,),*/
                          ],
                        ),
                        !displayMobileLayout?  SizedBox(
                          width: 50,
                        ):SizedBox(
                          width: 10,
                        ),
                        userDataList!=null? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userDataList!.firstName!),
                            SizedBox(height: 14,),
                            Text(userDataList!.email!),
                            SizedBox(height: 14,),
                            Text(userDataList!.countryCode!+""+userDataList!.phoneNumber!),
                            SizedBox(height: 14,),
                          ],
                        ):Container(),
                      ],
                    ),
                  )
              ),
            ),
          ],)
    );
  }
}