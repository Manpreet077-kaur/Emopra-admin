import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'side_menu.dart';

class AppSideMenu extends StatelessWidget {
  const AppSideMenu({required this.body, required this.pageTitle, Key? key})
      : super(key: key);
  final Widget body;
  final String pageTitle;
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Row(
      children: [/**/
        if (!displayMobileLayout)
          const SideMenu(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: displayMobileLayout? AppBar(
                automaticallyImplyLeading: displayMobileLayout,
                title: Text(pageTitle),
                backgroundColor: HexColor("#112153"),
              ):null,
              drawer: displayMobileLayout ? const SideMenu(
                permanentlyDisplay: false,
              )
                  : null,
              body: body,
            ),
          ),
        )
      ],
    );
  }
}