import 'package:flutter/material.dart';
import 'package:manager/config/gsheet_config.dart';
import 'package:manager/config/responsive_config.dart';
import 'package:manager/screens/request_items/request_items_screen.dart';
import 'package:manager/widgets/aerobotix_logo.dart';
import 'package:manager/widgets/error_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
          child: Column(
            children: [
              const AerobotixLogo(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * .06,
                    right: SizeConfig.screenWidth * .06,
                    top: SizeConfig.screenHeight * .03,
                  ),
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * .08),
                  decoration: const BoxDecoration(
                    color: Color(0xFFADD8E6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  width: SizeConfig.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.screenHeight * .15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.grey;
                                  } else {
                                    return const Color(0xffd95252);
                                  }
                                },
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(Size(
                                SizeConfig.screenWidth * .4,
                                SizeConfig.screenHeight * .08,
                              ))),
                          onPressed: () async {
                            if (!SpreadSheet.init) {
                              if (SpreadSheet.running) {
                                showErrorDialog(
                                  context: context,
                                  height: SizeConfig.screenHeight * .15,
                                  title: "Error",
                                  error: "Try again",
                                );
                                return;
                              }
                              await SpreadSheet.initSheet();
                            }
                            if (SpreadSheet.lastError
                                .endsWith("already been initialized.")) {
                              SpreadSheet.init = true;
                            }

                            if (!SpreadSheet.init) {
                              showErrorDialog(
                                context: context,
                                height: SizeConfig.screenHeight * .15,
                                title: "Error",
                                error:
                                    "Could not connect. \nVerify your internet connection.\nMake your your system's time is correct.\nError: " +
                                        SpreadSheet.lastError,
                              );
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const ReqItemsScreen(),
                              ),
                            );
                          },
                          child: const Text("New demand"),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
