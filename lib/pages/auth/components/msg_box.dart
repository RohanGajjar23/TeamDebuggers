import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MsgBox extends StatelessWidget {
  const MsgBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height / 10,
        left: size.width / 20,
      ),
      child: Container(
          width: size.width / 1.1,
          height: size.height / 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.theme.colorScheme.background),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: size.width / 1.13,
            height: size.height / 17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text("msgText",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.varelaRound(
                          textStyle: TextStyle(
                        fontSize: size.height / 50,
                        color: Get.theme.colorScheme.tertiary,
                      ))),
                ),
                InkWell(
                  // onTap: () async {
                  // await animationController?.reverse().orCancel;
                  // Provider.of<MsgBoxProvider>(context, listen: false)
                  // .ShowHide(
                  //     false, isSuccess, context, animationController!);
                  // },
                  child: Icon(
                    Icons.cancel,
                    size: size.height / 40,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
