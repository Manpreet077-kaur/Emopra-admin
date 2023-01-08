import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/header.dart';
import 'package:flutter_emporasports/model/dashboard_total_user_response.dart';
import 'package:flutter_emporasports/model/user_earn.dart';
import 'package:flutter_emporasports/screen/dashboard/dashboard_view.dart';
import 'package:flutter_emporasports/untils/constants.dart';
import 'package:flutter_emporasports/untils/responsive_web_app.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../components/app_side_menu.dart';
import '../../widget/all_widgets.dart';
import 'dashboard_presenter.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> implements DashboardInterface{
  var isLoading = false;
 List<UserEarnInfo> userEarnData = [];
  late DashboardPresenter dashboardPresenter;
  @override
  void initState() {
    super.initState();
    dashboardPresenter = DashboardPresenter(this);
    setState(() {
      isLoading=true;
      dashboardPresenter.doDashboardUserAPI();
    });}
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
        pageTitle: "Dashboard",
        body: WillPopScope(
          onWillPop:_onWillPop ,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: HexColor("#EFF1F5"),
                  child: Column(
                    children: [
                      Header(title: "Dashboard",type:0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                            color: Colors.white
                        ),
                        margin: EdgeInsets.all(22),
                        padding: EdgeInsets.all(22),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  userEarnData!=null?  DashBoardView(dataList: userEarnData,):Container(),
                                  SizedBox(height: Constants.defaultPadding),
                                  if (ResponsiveWebApp.isMobile(context))
                                    SizedBox(height: Constants.defaultPadding),
                                ],
                              ),
                            ),
                            if (!ResponsiveWebApp.isMobile(context))
                              SizedBox(width: Constants.defaultPadding),
                            // On Mobile means if the screen is less than 850 we dont want to show it
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                AllWidgets.progressDialogs(context, isLoading),
              ],
            ),
          ),
        )
    );
  }

  @override
  onDashboardSuccess(DashboardUserResponse user) {
    setState(() {
      isLoading=false;
    userEarnData =
      [
         UserEarnInfo(title: "Total Earning", total:"\$ "+double.parse((user.data!.totalEarning!.toDouble()).toStringAsFixed(2)).toString()),
         UserEarnInfo(title: "Total User",   total: user.data!.totalUsers.toString() ),
      ];
    });
  }

  @override
  onError(int errorCode) {
    setState(() {
      isLoading=false;
    });
  }
}


