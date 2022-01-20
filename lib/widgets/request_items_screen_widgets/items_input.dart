import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';
import 'package:manager/models/item.dart';
import 'package:manager/services/google_sheet_tools.dart';
import 'package:manager/services/qr_scanner.dart';
import 'package:manager/widgets/error_dialog.dart';

import 'items_list_widget.dart';

// ignore: must_be_immutable
class ItemsInputLevel1 extends StatefulWidget {
  List<ItemDesc> items = [];

  ItemsInputLevel1({Key? key}) : super(key: key);

  @override
  _ItemsInputLevel1 createState() => _ItemsInputLevel1();
}

class _ItemsInputLevel1 extends State<ItemsInputLevel1> {
  int modify = -1;
  late ButtonStyle style;

  TextEditingController nameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  _ItemsInputLevel1() {
    qtyController.text = "1";
  }
  @override
  Widget build(BuildContext context) {
    style = ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        Size(
          SizeConfig.screenWidth * .16,
          SizeConfig.screenHeight * .055,
        ),
      ),
      maximumSize: MaterialStateProperty.all<Size>(
        Size(
          SizeConfig.screenWidth * .2,
          SizeConfig.screenHeight * .055,
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * .01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * .6,
                child: TextField(
                  controller: nameController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    hintText: "Item name",
                    labelText: "Item name",
                  ),
                ),
              ),
              ElevatedButton(
                style: style,
                onPressed: () async {
                  String res = await QRScanner.scanQR(context);
                  int row = await SheetTools.itemExist(res);

                  if (row == -1) {
                    showErrorDialog(
                      context: context,
                      height: SizeConfig.screenHeight * .15,
                      title: "Error",
                      error: "Invalid item code.",
                    );
                    return;
                  }

                  var fullName = await SheetTools.getItem(row);
                  nameController.text = fullName;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Scan"), Text("QR")],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: SizeConfig.screenHeight * .02),
                width: SizeConfig.screenWidth * .3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: qtyController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    hintText: "Quantity",
                    labelText: "Quantity",
                  ),
                ),
              ),
              (modify != -1
                  ? ElevatedButton(
                      style: style,
                      onPressed: () {
                        setState(() {
                          modify = -1;
                          nameController.text = "";
                          qtyController.text = "1";
                        });
                      },
                      child: const Text("Cancel"),
                    )
                  : Container()),
              ElevatedButton(
                style: style,
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  setState(() {
                    if (modify == -1) {
                      for (ItemDesc item in widget.items) {
                        if (item.name == nameController.text) {
                          item.qty = (int.parse(item.qty) +
                                  int.parse(qtyController.text))
                              .toString();
                          qtyController.text = "1";
                          nameController.text = "";
                          return;
                        }
                      }
                      widget.items.add(
                          ItemDesc(nameController.text, qtyController.text));
                    } else {
                      widget.items[modify].name = nameController.text;
                      widget.items[modify].qty = qtyController.text;
                      modify = -1;
                    }
                    qtyController.text = "1";
                    nameController.text = "";
                  });
                },
                child: (modify != -1 ? const Text("Edit") : const Text("Add")),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.screenHeight * .02,
              left: SizeConfig.screenWidth * .02,
              right: SizeConfig.screenWidth * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Items (Total: " + widget.items.length.toString() + "):"),
                const Text("Tap to edit. Hold to remove"),
                ItemsList(
                  items: widget.items,
                  tileHold: (index) {
                    setState(() {
                      widget.items.removeAt(index);
                      if (index == modify) {
                        modify = -1;
                        nameController.text = "";
                        qtyController.text = "1";
                      }
                    });
                  },
                  tileClick: (index) {
                    setState(() {
                      modify = index;
                      nameController.text = widget.items[index].name;
                      qtyController.text = widget.items[index].qty;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
