import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';

class AerobotixLogo extends StatelessWidget {
  const AerobotixLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * .05),
      child: Center(
        child: Image.asset('assets/aerobotix.png',
            width: SizeConfig.screenWidth * .5,
            height: SizeConfig.screenHeight * .08),
      ),
    );
  }
}
