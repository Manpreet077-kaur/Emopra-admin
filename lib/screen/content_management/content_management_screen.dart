import 'package:flutter/material.dart';
import 'package:flutter_emporasports/components/app_side_menu.dart';

class ContentManagement extends StatefulWidget {
  @override
  _ContentManagementState createState() => _ContentManagementState();
}

class _ContentManagementState extends State<ContentManagement> {
  @override
  Widget build(BuildContext context) {
    return AppSideMenu(pageTitle: "Content Management",
      body: Center(
        child: Text("Content Management"),
      ),
    );
  }
}
