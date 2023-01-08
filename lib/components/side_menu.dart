
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/logout_presenter.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/route/route_name.dart';
import 'package:flutter_emporasports/route/route_observer.dart';
import 'package:flutter_emporasports/screen/login/login_screen.dart';
import 'package:flutter_emporasports/untils/responsive.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widget/all_widgets.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with RouteAware  implements ApiLogoutInterface{
  String? _selectedRoute;
  AppRouteObserver? _routeObserver;
  late LogoutPresenter logoutPresenter;
  var isLoading=false;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
    logoutPresenter = LogoutPresenter(this);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Drawer(
          backgroundColor: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                 Center(
                   child: Container(
                             margin: EdgeInsets.all(42),
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: 38,
                              color: HexColor("#65A2A2")
                            )),
                 ),
                    DrawerListTile(
                      title: "Dashboard",
                      svgSrc: "assets/images/icon_dashboard.png",
                      press: () async {
                        await _navigateTo(context, RouteNames.dashboard);
                      },
                    ),
                    DrawerListTile(
                      title: "Category",
                      svgSrc: "assets/images/icon_category.png",
                      press: () async {
                        await _navigateTo(context, RouteNames.categoryList);
                      },
                    ),
                    DrawerListTile(
                      title: "View User",
                      svgSrc: "assets/images/icon_viewuser.png",
                      press: () async {
                        await _navigateTo(context, RouteNames.viewuser);
                      },
                    ),
                    DrawerListTile(
                      title: "Deactivate User",
                      svgSrc: "assets/images/icon_viewuser.png",
                      press: () async {
                        await _navigateTo(context, RouteNames.inActiveUser);
                      },
                    ),
                    ExpansionTile(
                      title: Text("Content Mangment",
                          style: TextStyle(color: HexColor("#65A2A2"))),
                      leading: Image.asset("assets/images/icon_content.png",
                       color: HexColor("#65A2A2"),
                       height: 16,),
                     children: [
                       GestureDetector(
                         onTap: () async{
                           await _navigateTo(context, RouteNames.termsConditionScreen);
                         },
                         child: Container(
                           margin: EdgeInsets.only(left: 70,top: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Term & Condition", style: TextStyle(color: HexColor("#65A2A2"))),
                             ],
                           ),
                         ),
                       ),
                       GestureDetector(
                         onTap: () async{
                           await _navigateTo(context, RouteNames.privacyPolicyScreen);
                         },
                         child: Container(
                           margin: EdgeInsets.only(left: 70,top: 20,bottom: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Privacy Policy", style: TextStyle(color: HexColor("#65A2A2"))),
                             ],
                           ),
                         ),
                       ),
                     ],
                     /* svgSrc: "assets/icons/menu_tran.svg",
                      press: () async {
                        await _navigateTo(context, RouteNames.contentManagement);
                      },*/
                    ),
                    DrawerListTile(
                      title: "Change Password",
                      svgSrc: "assets/images/icon_changepwd.png",
                      press: () async {
                        await _navigateTo(context, RouteNames.changePasswordScreen);

                      },
                    ),
                    DrawerListTile(
                      title: "Logout",
                      svgSrc: "assets/images/icon_logout.png",
                      press: () {
                        showAlertForgotDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              if (widget.permanentlyDisplay)
                const VerticalDivider(
                  width: 1,
                )
            ],
          ),
        ),
        AllWidgets.progressDialogs(context, isLoading)
      ],
    );
  }
  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
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
                  forLargeScreen: MediaQuery.of(context).size.width/4,
                  context: context),
              height:  Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.height/3,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40,bottom: 10.0),
                    child: Center(
                      child: Image.asset("assets/images/logo.png",height: 30,color: Colors.black,
                        width: MediaQuery.of(context).size.width/2.5,),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                 /* Center(
                    child:
                    Text("Log Out",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                  ),*/
                  Center(
                    child:
                    Text("Are you sure want to log out?",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: HexColor("#112153"))
                            ),
                            child: Text("Cancel",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                          ),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                               isLoading=true;
                              });
                              logoutPresenter.doLogout();
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#65A2A2"),
                              ),
                              child: Text("Log Out",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }


  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context)!.settings.name;
    });
  }

  @override
  onError(String msg, int errorCode) {
    setState(() {
      isLoading=false;
    });
    AllWidgets.customDialog(msg);
   }

  @override
  onLogoutSuccess(SuccessResponse logoutUser) {
    setState(() {
      isLoading=false;
    });
    if(logoutUser.statusCode==200){
      AllWidgets.customDialog(logoutUser.message!);
      Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
    }
    else{
      AllWidgets.customDialog(logoutUser.message!);
    }
  }
}
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        svgSrc,
        color: HexColor("#65A2A2"),
        height: 16,
      ),
      title: Container(
          margin: EdgeInsets.only(left: 16),
        child: Text(
            title,
            style: TextStyle(color: HexColor("#65A2A2"))
        ),
      ),
    );
  }

}