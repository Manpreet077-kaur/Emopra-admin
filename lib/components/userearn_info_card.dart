import 'package:flutter/material.dart';
import 'package:flutter_emporasports/model/dashboard_total_user_response.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/user_earn.dart';
import '../untils/constants.dart';

class UserEarnInfoCard extends StatelessWidget {
   UserEarnInfoCard({
    Key? key, required this.info,
  }) : super(key: key);
   final UserEarnInfo info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.defaultPadding),
      decoration: BoxDecoration(
        color: HexColor("#65A2A2"),
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(info.title.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 18),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info.total.toString(),
                style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = const Color(0xFF2697FF),
    required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
          ),
        )
      ],
    );
  }
}
