import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emporasports/model/category_data.dart';
import 'package:flutter_emporasports/model/user_data.dart';
import 'package:flutter_emporasports/untils/constants.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/category_list_response.dart';

class CategoryView extends StatelessWidget {
  List<CategoryListData> categoryList;
   CategoryView({
    required this.categoryList
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                DataColumn(
                  label: Text("Description"),
                ),
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
    );
  }
}

DataRow recentFileDataRow(CategoryListData categoryData) {
  return DataRow(
    cells: [
      DataCell(Text(categoryData.id.toString())),
      DataCell(Text(categoryData.categoryName.toString())),
      DataCell(Text(categoryData.categoryName.toString())),
      DataCell(Image.asset("assets/images/profile_pic.png",height: 20, width: 20),),
      DataCell(Row(
        children: [
          // Image.asset("assets/images/ic_disable.png",height: 20, width: 20),
          // SizedBox(width:4),
          Image.asset("assets/images/ic_edit.png",height: 16, width: 16),
          SizedBox(width:4),
          GestureDetector(
              onTap: (){

              },
              child: Image.asset("assets/images/ic_delete.png",height: 16, width: 16)),
        ],
      )),
    ],
  );
}
