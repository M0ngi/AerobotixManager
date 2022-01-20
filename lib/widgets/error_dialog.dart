import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';

void showErrorDialog(
    {required context, required height, required title, required error}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            margin: EdgeInsets.only(
              right: SizeConfig.screenWidth * .05,
              left: SizeConfig.screenWidth * .03,
            ),
            child: Text(error),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: SizeConfig.screenWidth * .035),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.red),
                  ),
                  child: const Text('Dismiss')),
            ),
          ],
        );
      });
}
