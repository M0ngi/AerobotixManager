import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';
import 'package:manager/services/google_sheet_tools.dart';
import 'package:manager/services/qr_scanner.dart';
import 'package:manager/widgets/aerobotix_logo.dart';
import 'package:manager/widgets/error_dialog.dart';
import 'package:manager/widgets/request_items_screen_widgets/demand_success.dart';
import 'package:manager/widgets/request_items_screen_widgets/items_input.dart';
import 'package:manager/widgets/request_items_screen_widgets/next_back_buttons.dart';
import 'package:manager/widgets/request_items_screen_widgets/name_input.dart';

class ReqItemsScreen extends StatefulWidget {
  const ReqItemsScreen({Key? key}) : super(key: key);

  @override
  _ReqItemsScreen createState() => _ReqItemsScreen();
}

class _ReqItemsScreen extends State<ReqItemsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController typeRobot = TextEditingController();
  TextEditingController nomCompt = TextEditingController();
  int level = 0;
  final ItemsInputLevel1 itemsInputScreen = ItemsInputLevel1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(() {
          switch (level) {
            case 0:
              return "Member Info";
            case 1:
              return "Items";
            default:
              return "Success";
          }
        }()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const AerobotixLogo(),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .015,
                  right: SizeConfig.screenWidth * .015,
                  top: SizeConfig.screenHeight * .01,
                ),
                margin: EdgeInsets.only(top: SizeConfig.screenHeight * .08),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                width: SizeConfig.screenWidth,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.screenHeight * .03,
                      left: SizeConfig.screenWidth * .08,
                      right: SizeConfig.screenWidth * .08,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * .55,
                            child: () {
                              switch (level) {
                                case 0:
                                  return NameInputLevel0(
                                    nameController: name,
                                    comptController: nomCompt,
                                    typeController: typeRobot,
                                    qrButtonEvent: () async {
                                      var res = await QRScanner.scanQR(context);

                                      int row =
                                          await SheetTools.membreExist(res);
                                      if (row == -1) {
                                        showErrorDialog(
                                          context: context,
                                          height: SizeConfig.screenHeight * .15,
                                          title: "Error",
                                          error: "Invalid ID Code.",
                                        );
                                        return;
                                      }

                                      name.text = await SheetTools.getName(row);
                                      if (nomCompt.text.isNotEmpty &&
                                          typeRobot.text.isNotEmpty) {
                                        setState(() {
                                          level++;
                                        });
                                      }
                                    },
                                  );
                                case 1:
                                  return itemsInputScreen;
                                case 2:
                                  return const SuccessDemand();
                              }
                            }(),
                          ),
                          NextBackButton(
                            nextCall: () async {
                              if (name.text.isEmpty ||
                                  nomCompt.text.isEmpty ||
                                  typeRobot.text.isEmpty) {
                                showErrorDialog(
                                  context: context,
                                  height: SizeConfig.screenHeight * .15,
                                  title: "Error",
                                  error: "Fill the member's info.",
                                );
                              }
                              switch (level) {
                                case 0:
                                  {
                                    if (name.text.replaceAll(" ", "").isEmpty) {
                                      showErrorDialog(
                                        context: context,
                                        height: SizeConfig.screenHeight * .15,
                                        title: "Error",
                                        error: "Invalid name (EMPTY).",
                                      );
                                      return;
                                    }
                                    setState(() {
                                      level++;
                                    });
                                    break;
                                  }
                                case 1:
                                  {
                                    if (itemsInputScreen.items.isEmpty) {
                                      showErrorDialog(
                                        context: context,
                                        height: SizeConfig.screenHeight * .15,
                                        title: "Error",
                                        error: "Invalid list (EMPTY).",
                                      );
                                      return;
                                    }

                                    await SheetTools.addDemand(
                                        name.text,
                                        nomCompt.text,
                                        typeRobot.text,
                                        itemsInputScreen.items);

                                    setState(() {
                                      level++;
                                    });
                                    break;
                                  }
                                default:
                                  {
                                    setState(() {
                                      level = 0;
                                    });
                                  }
                              }
                            },
                            backCall: (level > 0
                                ? () {
                                    if (level >= 2) {
                                      setState(() {
                                        level = 0;
                                      });
                                      name.text = "";
                                      itemsInputScreen.items.clear();
                                    } else {
                                      setState(() {
                                        level--;
                                      });
                                    }
                                  }
                                : null),
                            level: level,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
