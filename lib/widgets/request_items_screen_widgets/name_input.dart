import 'package:flutter/material.dart';
import 'package:manager/config/responsive_config.dart';

class NameInputLevel0 extends StatelessWidget {
  final TextEditingController nameController, typeController, comptController;
  final void Function()? qrButtonEvent;
  const NameInputLevel0(
      {required this.nameController,
      required this.qrButtonEvent,
      required this.typeController,
      required this.comptController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * .04),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * .6,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    hintText: "Leader name",
                    labelText: "Leader's name",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: qrButtonEvent,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(SizeConfig.screenWidth * .1, 45),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Scan"), Text("QR")],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * .03),
            child: TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                hintText: "Type robot",
                labelText: "Type robot",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * .03),
            child: TextField(
              controller: comptController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                hintText: "Competition",
                labelText: "Competition",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
