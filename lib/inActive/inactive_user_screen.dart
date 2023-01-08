import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/app_side_menu.dart';
import 'package:flutter_emporasports/inActive/inactiveuser_presenter.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/screen/profile/profile_screen.dart';
import 'package:flutter_emporasports/screen/viewuser/viewuser_presenter.dart';
import 'package:flutter_emporasports/untils/color_utils.dart';
import 'package:flutter_emporasports/untils/constants.dart';
import 'package:flutter_emporasports/untils/responsive_web_app.dart';
import 'package:flutter_emporasports/widget/all_widgets.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../components/header.dart';
import '../../model/user_list_response.dart';
import '../../untils/responsive.dart';

class InActiveScreen extends StatefulWidget {
  @override
  _InActiveScreenState createState() => _InActiveScreenState();
}

class _InActiveScreenState extends State<InActiveScreen> implements InActiveUserInterface{
  var isLoading = false;
  TextEditingController _searchController = TextEditingController();
  late InActiveUserPresenter inActiveUserPresenter;
  List<Rows> userDataList=[];
  List <Rows> _searchList = [] ;
  var status=1;
  int skip=0;
  int _currentPage=1;
  int limit=6;
  double _totalpage=0;
  @override
  void initState() {
    super.initState();
    inActiveUserPresenter = InActiveUserPresenter(this);
    setState(() {
      isLoading=true;
      inActiveUserPresenter.doInActiveListAPI(skip,limit);
    });
  }
  void _searchingData(String enteredKeyword) {
    List<Rows> results = [];
    if (enteredKeyword.isEmpty) {
      results = _searchList;
    } else {
      results = _searchList
          .where((user) =>
          user.firstName!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      userDataList = results;
    });
  }
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return AppSideMenu( pageTitle: "View User",
      body:  SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: HexColor("#EFF1F5"),
              child: Column(
                children: [
                  Header(title: "View User",type:1),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width:displayMobileLayout? MediaQuery.of(context).size.width:
                          MediaQuery.of(context).size.width/4,
                          child: Card(
                              margin: EdgeInsets.only(top: 10,left:20,right: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 8.0,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                onChanged: (value) => _searchingData(value),
                                controller: _searchController,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search,size: 24,color: Colors.black,),
                                  hintText: "Search",
                                  hintStyle:TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal),
                                ),
                              )
                          )),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userDataList.length!=0?Expanded(
                        flex:userDataList.length,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: DataTable2(
                                      columnSpacing: Constants.defaultPadding,
                                      minWidth: 600,
                                      columns: [
                                        DataColumn(
                                          label: Text("ID"),
                                        ),
                                        DataColumn(
                                          label: Text("Email"),
                                        ),
                                        DataColumn(
                                          label: Text("Registered"),
                                        ),
                                        DataColumn(
                                          label: Text("Update Status"),
                                        ),
                                        DataColumn(
                                          label: Text("Action"),
                                        ),
                                      ],
                                      rows: List.generate(
                                        userDataList.length,
                                            (index) => recentFileDataRow(userDataList[index],context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (ResponsiveWebApp.isMobile(context))
                              SizedBox(height: Constants.defaultPadding),
                          ],
                        ),
                      ):Center(child: Container()),
                      if (!ResponsiveWebApp.isMobile(context))
                        SizedBox(width: Constants.defaultPadding),
                    ],
                  ),
                  userDataList.length!=0?WebPagination(
                      currentPage: _currentPage,
                      totalPage: _totalpage.toInt(),
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage=page;
                          skip=skip+6;
                          // _currentPage=_currentPage+1;
                          userDataList.clear();
                          isLoading=true;
                          inActiveUserPresenter.doInActiveListAPI(skip,limit);
                        });
                      }):Container(),
                ],
              ),
            ),
            AllWidgets.progressDialogs(context, isLoading),
            AllWidgets.noRecord(context, userDataList.length)
          ],
        ),
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
  onViewUserSuccess(UserListResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.statusCode==200){
      setState(() {
        isLoading=false;
        userDataList.addAll(user.data!.rows!);
        _totalpage=user.data!.count!/6;
        _searchList=userDataList;
      });
    }
    else{
    }
  }

  DataRow recentFileDataRow(Rows userInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(Constants.USER_IMAGE_URL+""+userInfo.profilePicture!,errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace){
                return  Icon(Icons.perm_identity_sharp,size: 20,color: HexColor("#65A2A2"),);
              },
              height: 20, width: 20),
              // Image.asset("assets/images/profile_pic.png",height: 20, width: 20),
              SizedBox(width:4),
              Text(userInfo.firstName!,style: TextStyle(fontSize: 12),),
            ],
          ),
        ),

        DataCell(Text(userInfo.email!,style: TextStyle(fontSize: 12),)),
        DataCell(Text(dateConvertor(userInfo.createdAt.toString()),style: TextStyle(fontSize: 12),)),
        DataCell(GestureDetector(
          onTap: (){
              showAlertblockDialog(
                  context, userInfo.id.toString(), status.toString());
          },
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: userInfo.status==true ?HexColor("#3FB85C"):AppColor.btn_red
            ),
            child:Text(userInfo.status==true?"Activate":"Deactivate",style: TextStyle(color: Colors.white,fontSize: 12),) ,
          ),
        ),),
        DataCell(GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    id: userInfo.id.toString(),
                  ),
                ));
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.lightBlue
            ),
            child:Text("Show",style: TextStyle(color: Colors.white,fontSize: 12),) ,
          ),
        ),),
      ],
    );
  }

  @override
  onBlockUserSuccess(SuccessResponse user) {
   setState(() {
     isLoading=false;
   });
   AllWidgets.customDialog(user.message!);
   userDataList.clear();
   setState(() {
     isLoading=true;
     inActiveUserPresenter.doInActiveListAPI(skip,limit);
   });
  }
  //get date from date
  String dateConvertor(String date) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime gettingDate = format.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(gettingDate);
    return formatted;
  }

  showAlertblockDialog(BuildContext context, String user_id, String status ) {
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
                    Text("Are you sure want to activate this User?",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
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
                            child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                          ),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isLoading=true;
                              });
                              inActiveUserPresenter.doUserBlockAPI(user_id, status);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#65A2A2"),
                              ),
                              child: Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
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

}
