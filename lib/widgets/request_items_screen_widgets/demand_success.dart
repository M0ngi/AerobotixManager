import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager/config/responsive_config.dart';

class SuccessDemand extends StatelessWidget {
  const SuccessDemand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * .05,
            bottom: SizeConfig.screenHeight * .05,
          ),
          child: Text(
            "Demand saved successfully!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 3,
            ),
          ),
        ),
        SvgPicture.asset(
          'assets/doneIcon.svg',
          height: SizeConfig.screenHeight * .15,
        ),
      ],
    );
  }
}
