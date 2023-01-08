import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/app_side_menu.dart';
import 'package:flutter_emporasports/model/category_list_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/route/route_name.dart';
import 'package:flutter_emporasports/screen/category/addcategory_screen.dart';
import 'package:flutter_emporasports/untils/constants.dart';
import 'package:flutter_emporasports/untils/responsive_web_app.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../untils/responsive.dart';
import '../../widget/all_widgets.dart';
import 'category_presenter.dart';


class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> implements CategoryInterface{
  var isLoading = false;
  List<CategoryListData> categoryList=[];
  late CategoryPresenter categoryPresenter;
  @override
  void initState() {
    categoryPresenter = CategoryPresenter(this);
    setState(() {
      isLoading=true;
      categoryPresenter.doCategoryListAPI();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppSideMenu( pageTitle: "Category",
    body:  SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: HexColor("#EFF1F5"),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(color:Colors.black),
                        ),
                        Spacer(flex: 2),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, RouteNames.addcategory);
                          },
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(left: 20.0,right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: HexColor("#65A2A2"),
                            ),
                            child: Text("Add Category",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryList.length!=0? Expanded(
                        flex: categoryList.length,
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
                                          label: Text("Sr.No."),
                                        ),
                                        DataColumn(
                                          label: Text("Name"),
                                        ),
                                        /*DataColumn(
                                          label: Text("Description"),
                                        ),*/
                                        DataColumn(
                                          label: Text("Image"),
                                        ),
                                        DataColumn(
                                          label: Text("Action"),
                                        ),
                                      ],
                                      rows: List.generate(
                                        categoryList.length,
                                            (index) => recentFileDataRow(categoryList[index]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // CategoryView(categoryList:categoryList,),
                            if (ResponsiveWebApp.isMobile(context))
                              SizedBox(height: Constants.defaultPadding),
                          ],
                        ),
                      ):Container(),
                      if (!ResponsiveWebApp.isMobile(context))
                        SizedBox(width: Constants.defaultPadding),
                    ],
                  )
                ],
              ),
            ),
            AllWidgets.progressDialogs(context, isLoading)
          ],
        ),
      ),
    );
  }

  @override
  onAddCategorySuccess(SuccessResponse user) {}
  @override
  onCategoryListError(int msg) {
    setState(() {
      isLoading=false;
    });
  }
  @override
  onError(String msg, int errorCode) {}

  @override
  onCategoryListSuccess(CategoryListResponse user) {
    if(user.statusCode==200){
      setState(() {
        isLoading=false;
        categoryList.addAll(user.data!);
      });
    }
    else{
    }

  }
  DataRow recentFileDataRow(CategoryListData categoryData) {
    return DataRow(
      cells: [
        DataCell(Text(categoryData.id.toString())),
        DataCell(Text(categoryData.categoryName.toString())),
        // DataCell(Text(categoryData.categoryName.toString())),
        DataCell(Image.network(Constants.CATEGORY_IMAGE_URL+categoryData.categoryImage.toString(),
            errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace){
          return Image.asset("assets/images/profile_pic.png",height: 20, width: 20);
        },
            height: 20, width: 20),),
        DataCell(Row(
          children: [
            // Image.asset("assets/images/ic_disable.png",height: 20, width: 20),
            // SizedBox(width:4),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>AddCategoryScreen(categoryId:categoryData.id.toString(),categoryName: categoryData.categoryName.toString(),imageUrl: Constants.CATEGORY_IMAGE_URL+categoryData.categoryImage.toString(),)));
                },
                child: Image.asset("assets/images/ic_edit.png",height: 16, width: 16)),
            SizedBox(width:4),
            GestureDetector(
                onTap: (){
                  showAlertDeleteDialog(context,categoryData.id.toString());
                },
                child: Image.asset("assets/images/ic_delete.png",height: 16, width: 16)),
          ],
        )),
      ],
    );
  }

  @override
  onDeleteRequestSuccess(SuccessResponse successResponse) {
    setState(() {
      isLoading=false;
    });
    Fluttertoast.showToast(
        msg: successResponse.message!,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        gravity: ToastGravity.BOTTOM);
    categoryList.clear();
    setState(() {
      isLoading=true;
      categoryPresenter.doCategoryListAPI();
    });
  }
  showAlertDeleteDialog(BuildContext context, String category_id,) {
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

                  Center(
                    child:
                    Text("Are you sure want to delete category?",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
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
                              categoryPresenter.deleteAPI(category_id);
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
