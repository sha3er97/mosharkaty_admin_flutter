import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';

commonAppBar(
  BuildContext context,
  String name, //bool isDark,
  {
  PreferredSize? bottom,
  bool? noLead,
  Color? backgroundColor,
  Color? buttonColor,
}) {
  return AppBar(
    toolbarHeight: 50,
    backgroundColor: backgroundColor ?? AppColors.white,
    //isDark ? kcbackDarkColor : kcwhite,
    elevation: 0,
    leadingWidth: 50,
    title: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(name,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            //isDark ? kcwhite : kcblack,
            fontFamily: "Avenir",
            fontSize: 20,
          )),
    ),
    centerTitle: false,
    leading: noLead == null
        ? Padding(
            padding: const EdgeInsets.only(top: 10, left: 5),
            child: BackButton(
              color:
                  buttonColor ?? AppColors.black, //isDark ? kcwhite : kcblack,
            ))
        : emptyPlaceHolder,
    bottom: bottom,
  );
}
