import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';

class ItemDesc {
  String name;
  String qty;

  ItemDesc(this.name, this.qty);

  Widget buildTitle(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(name),
      );

  Widget buildSubtitle(BuildContext context) => Container(
        margin: EdgeInsets.only(left: SizeConfig.screenWidth * .025),
        child: Text(
          "Quantity: " + qty,
        ),
      );
}
