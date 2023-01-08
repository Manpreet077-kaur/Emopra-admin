
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/userearn_info_card.dart';
import 'package:flutter_emporasports/model/dashboard_total_user_response.dart';
import 'package:flutter_emporasports/model/user_earn.dart';
import 'package:flutter_emporasports/route/route_name.dart';
import 'package:flutter_emporasports/untils/constants.dart';
import 'package:flutter_emporasports/untils/responsive_web_app.dart';

class DashBoardView extends StatelessWidget {
  List<UserEarnInfo> dataList;
  DashBoardView({
    required this.dataList
  });

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
       /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (ResponsiveWebApp.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),*/
        SizedBox(height: Constants.defaultPadding),
        dataList!=""?  ResponsiveWebApp(
          mobile: InfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
            list:dataList,
          ),
          tablet: InfoCardGridView( list:dataList,),
          desktop: InfoCardGridView(
            list:dataList,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ):Container(),
      ],
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  const InfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.list,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  // final Data list;
  final List<UserEarnInfo> list;

  @override
  Widget build(BuildContext context) {
    return list!=""? GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: Constants.defaultPadding,
        mainAxisSpacing: Constants.defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => GestureDetector(
          onTap: (){
            if(index==1){
              Navigator.pushNamed(context, RouteNames.viewuser);
            }
          },
          child: UserEarnInfoCard(info: list[index],)),
    ):Container();
  }
}
