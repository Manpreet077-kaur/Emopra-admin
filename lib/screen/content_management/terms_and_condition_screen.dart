import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/screen/content_management/policy_presenter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../components/app_side_menu.dart';
import '../../components/header.dart';
import '../../widget/all_widgets.dart';

class TermsConditionScreen extends StatefulWidget {
  @override
  _TermsConditionScreenState createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> implements PolicyInterface{
  var isLoading = false;
  late PolicyPresenter policyPresenter;
  @override
  void initState() {
    super.initState();
    policyPresenter = PolicyPresenter(this);
   }
  HtmlEditorController controller = HtmlEditorController();
  var result = '';
  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
      pageTitle: 'Terms & Condition',
      body: Stack(
        children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: HexColor("#EFF1F5"),
              child: Header(title: "Terms & Condition",type:1),
            ),
            Container(
              margin: EdgeInsets.only(left: 62,right: 62,top: 20 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    width: MediaQuery.of(context).size.width,
                    child: HtmlEditor(
                      controller: controller,
                      htmlEditorOptions: HtmlEditorOptions(
                        hint: 'Your text here...',
                        //shouldEnsureVisible: false,
                        //initialText: "<p>text content initial, if any</p>",
                      ),
                      htmlToolbarOptions: HtmlToolbarOptions(
                        defaultToolbarButtons: [
                          StyleButtons(),
                          FontSettingButtons(),
                          FontButtons(),
                          ListButtons(),
                          ParagraphButtons(),
                        ],
                        toolbarPosition: ToolbarPosition.aboveEditor, //by default
                        toolbarType: ToolbarType.nativeGrid, //by default
                        onButtonPressed: (ButtonType type, bool? status,
                            Function? updateStatus) {
                          print(
                              "button '${describeEnum(type)}' pressed, the current selected status is $status");
                          return true;
                        },
                        onDropdownChanged: (DropdownType type, dynamic changed,
                            Function(dynamic)? updateSelectedItem) {
                          print(
                              "dropdown '${describeEnum(type)}' changed to $changed");
                          return true;
                        },
                        mediaLinkInsertInterceptor:
                            (String url, InsertFileType type) {
                          print(url);
                          return true;
                        },
                        mediaUploadInterceptor:
                            (PlatformFile file, InsertFileType type) async {
                          print(file.name); //filename
                          print(file.size); //size in bytes
                          print(file.extension); //file extension (eg jpeg or mp4)
                          return true;
                        },
                      ),
                      otherOptions: OtherOptions(height: 240),
                      callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
                      }, onChangeContent: (String? changed) {
                      }, onChangeCodeview: (String? changed) {
                      }, onChangeSelection: (EditorSettings settings) {
                      }, onDialogShown: () {
                      }, onEnter: () {
                      }, onFocus: () {
                      }, onBlur: () {
                      }, onBlurCodeview: () {
                      }, onInit: () {
                      },
                          onImageUploadError: (FileUpload? file, String? base64Str,
                              UploadError error) {
                            print(describeEnum(error));
                            print(base64Str ?? '');
                            if (file != null) {
                              print(file.name);
                              print(file.size);
                              print(file.type);
                            }
                          }, onKeyDown: (int? keyCode) {
                          }, onKeyUp: (int? keyCode) {
                          }, onMouseDown: () {
                          }, onMouseUp: () {
                          }, onNavigationRequestMobile: (String url) {
                            print(url);
                            return NavigationActionPolicy.ALLOW;
                          }, onPaste: () {
                          }, onScroll: () {
                          }),
                      plugins: [
                        SummernoteAtMention(
                            getSuggestionsMobile: (String value) {
                              var mentions = <String>['test1', 'test2', 'test3'];
                              return mentions
                                  .where((element) => element.contains(value))
                                  .toList();
                            },
                            mentionsWeb: ['test1', 'test2', 'test3'],
                            onSelect: (String value) {
                              print(value);
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueGrey),
                          onPressed: () {
                            controller.undo();
                          },
                          child:
                          Text('Undo', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.secondary),
                          onPressed: () async {
                            var txt = await controller.getText();
                            if(txt.isEmpty){
                              AllWidgets.customDialog("Please enter text");
                            }else{
                              if (txt.contains('src=\"data:')) {
                                txt =
                                '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                              }
                              setState(() {
                                result = txt;
                                isLoading=true;
                              });
                              policyPresenter.doAddTermsConditions(result);
                              print("result::"+result);
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        AllWidgets.progressDialogs(context, isLoading),
      ],
      ),
    );
  }

  @override
  onError(String msg, int errorCode) {
    setState(() {
      isLoading=false;
    });
    AllWidgets.customDialog(msg);
  }

  @override
  onSuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.statusCode==200){
      AllWidgets.customDialog(user.message!);
    }
    else{
      AllWidgets.customDialog(user.message!);
    }
  }
}
