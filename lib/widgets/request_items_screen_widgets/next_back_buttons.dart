import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';

class NextBackButton extends StatelessWidget {
  final void Function()? nextCall, backCall;
  final int level;
  const NextBackButton(
      {required this.nextCall,
      required this.backCall,
      required this.level,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: SizeConfig.screenWidth * .04,
        right: SizeConfig.screenWidth * .04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            child: Text((level == 2 ? "New demand" : "Back")),
            onPressed: backCall,
          ),
          ElevatedButton(
            child: Text((level == 2 ? "Clone previous" : "Next")),
            onPressed: nextCall,
          ),
        ],
      ),
    );
  }
}
