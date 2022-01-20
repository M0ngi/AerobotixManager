import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';
import 'package:manager/models/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    Key? key,
    required this.items,
    required this.tileClick,
    required this.tileHold,
  }) : super(key: key);

  final List<ItemDesc> items;
  final Null Function(dynamic)? tileClick, tileHold;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 1),
          left: BorderSide(),
          right: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      margin: EdgeInsets.only(
        top: SizeConfig.screenHeight * .02,
        left: SizeConfig.screenWidth * .02,
        right: SizeConfig.screenWidth * .02,
      ),
      height: SizeConfig.screenHeight * .27,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            height: SizeConfig.screenHeight * .09,
            decoration: BoxDecoration(
                color: index & 1 == 0
                    ? const Color(0xFFD3D3D3)
                    : const Color(0xFFFFFFFF)),
            child: ListTile(
              onTap: () {
                tileClick!(index);
              },
              onLongPress: () {
                tileHold!(index);
              },
              title: items[index].buildTitle(context),
              subtitle: items[index].buildSubtitle(context),
            ),
          );
        },
      ),
    );
  }
}
