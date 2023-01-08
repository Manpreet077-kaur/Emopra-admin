import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/header.dart';
import 'package:flutter_emporasports/model/category_list_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/route/route_name.dart';
import 'package:flutter_emporasports/screen/category/category_presenter.dart';
import 'package:flutter_emporasports/untils/responsive.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../components/app_side_menu.dart';
import '../../untils/string_utils.dart';
import '../../widget/all_widgets.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';
class AddCategoryScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final String imageUrl;
  AddCategoryScreen(
      {Key? key,
        required this.categoryName,
        required this.categoryId,
        required this.imageUrl,
      })
      : super(key: key);
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> implements CategoryInterface{
  var isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  late CategoryPresenter categoryPresenter;
  @override
  void initState() {
    super.initState();
    categoryPresenter = CategoryPresenter(this);
    setState(() {
     nameController.text=widget.categoryName;
    });
  }
  List<int>? _selectedFile;
  Uint8List? _bytesData;
  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
      print("Pick ::: "+_selectedFile.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
        pageTitle: "Add Category",
        body: Container(
          color: HexColor("#EFF1F5"),
          child: Stack(
            children: [
              Column(
                children: [
                  Header(title: "Category",type:1),
                  SizedBox(height: 22,),
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    width:  Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width,
                        context: context),
                    child:  Card(
                        color: HexColor("#FFFFFF"),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Container(
                          width:  Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery.of(context).size.width,
                              context: context),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      startWebFilePicker();
                        },

                                    child: Container(
                                      height: Responsive().getResponsiveValue(
                                          forLargeScreen:  MediaQuery.of(context).size.height/3.2,
                                          forShortScreen:MediaQuery.of(context).size.height/4,
                                          forTabletScreen:MediaQuery.of(context).size.height/4,
                                          context: context),
                                      width: Responsive().getResponsiveValue(
                                          forLargeScreen: MediaQuery.of(context).size.width/8,
                                          forShortScreen:MediaQuery.of(context).size.width/3,
                                          forTabletScreen:MediaQuery.of(context).size.width/3,
                                          context: context),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey
                                        ),
                                    image:_selectedFile!=null?
                                        DecorationImage(
                                          image:MemoryImage(_bytesData!),
                                          fit: BoxFit.fill
                                        ):
                                    widget.imageUrl!=""?
                                    DecorationImage(
                                        image:NetworkImage(widget.imageUrl),
                                        fit: BoxFit.fill
                                    ):
                                    DecorationImage(
                                        image:AssetImage("assets/images/ic_screenshot.png"),

                                    )
                                      ),
                                    ),
                                    ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Add Your Photo",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 10.0,
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery.of(context).size.width/2,
                                        forShortScreen:MediaQuery.of(context).size.width/3.2,
                                        forTabletScreen:MediaQuery.of(context).size.width/3.2,
                                        context: context),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 8.0,
                                        child: TextFormField(
                                          controller: nameController,
                                          cursorColor: Colors.black,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                              hintText: "Name"),
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery.of(context).size.width/2,
                                        forShortScreen:MediaQuery.of(context).size.width/3.2,
                                        forTabletScreen:MediaQuery.of(context).size.width/3.2,
                                        context: context),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 8.0,
                                        child: TextFormField(
                                          controller: desController,
                                          cursorColor: Colors.black,
                                          minLines: 8, // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                              hintText: "Description"),
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (nameController.text.isEmpty) {
                                        AllWidgets.customDialog(UtilStrings.entername);
                                      }
                                      else if(_selectedFile==null && widget.imageUrl==""){
                                        AllWidgets.customDialog(UtilStrings.selectImage);
                                      }
                                      else if(widget.categoryName!="") {
                                        setState((){
                                          isLoading=true;
                                        });
                                        final http.Response responseData = await http.get(Uri.parse(widget.imageUrl));
                                        _selectedFile = responseData.bodyBytes;
                                        print("selectedFile::: "+_selectedFile.toString());
                                       categoryPresenter.doEditCategory(widget.categoryId,nameController.text.toString(),_selectedFile!,"true");
                                      }
                                      else{
                                        setState(() {
                                          isLoading=true;
                                        });
                                        categoryPresenter.doAddCategory(nameController.text, _selectedFile!);
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
                                      child: Text("Add",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
              AllWidgets.progressDialogs(context, isLoading),
            ],
          ),
        )
    );
  }


  @override
  onAddCategorySuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.statusCode==200){
      AllWidgets.customDialog(user.message!);
      Navigator.pushNamed(context, RouteNames.categoryList);
    }
    else{
      AllWidgets.customDialog(user.message!);
    }
  }

  @override
  onError(String msg, int errorCode) {
    setState(() {
      isLoading=false;
    });
    AllWidgets.customDialog(msg);
    print("error msg::"+msg);
  }

  @override
  onCategoryListError(int msg) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onCategoryListSuccess(CategoryListResponse user) {

  }

  @override
  onDeleteRequestSuccess(SuccessResponse successResponse) {
  }

}


