import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/res/colors.dart';

Widget ErrorMessageHeading(String title) {
  return Center(
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: FontStyleUtilities.h4(
        fontColor: AppColors.offerRed,
        // fontWeight: FontWeight.w700,
        // wordSpacing: 1.5,
      ),
    ),
  );
}

Widget EmptyMessageHeading([String? title]) {
  return Center(
    child: Text(
      title ?? "Nothing to show",
      textAlign: TextAlign.center,
      style: FontStyleUtilities.h5(
        fontColor: AppColors.lightBlack,
        // fontWeight: FontWeight.w700,
        // wordSpacing: 1.5,
      ),
    ),
  );
}

/// THIS ENUM IS USED TO MANAGE FONT_WEIGHT...
enum FWT { light, regular, medium, semiBold, bold, extrabold }

/// THIS CLASS IS USED TO MANAGE FONT_STYLES USED IN THE APPLICATION...
class FontStyleUtilities {
  /// THIS FUNCTION RETURNS FONT_WEIGHT ACCORDING TO USER REQUIREMENT(FROM ENUM)...
  static FontWeight getFontWeight({FWT? fontWeight = FWT.regular}) {
    switch (fontWeight) {
      case FWT.extrabold:
        return FontWeight.w800;
      case FWT.bold:
        return FontWeight.w700;
      case FWT.semiBold:
        return FontWeight.w600;
      case FWT.medium:
        return FontWeight.w500;
      case FWT.regular:
        return FontWeight.w400;
      case FWT.light:
        return FontWeight.w300;
      default:
        return FontWeight.w400;
    }
  }

  /// FONT STYLE FOR FONT SIZE 34
  static TextStyle h1({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 34,
    );
  }

  /// FONT STYLE FOR FONT SIZE 30
  static TextStyle h2({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 30,
    );
  }

  /// FONT STYLE FOR FONT SIZE 24
  static TextStyle h3({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 24,
    );
  }

  /// FONT STYLE FOR FONT SIZE 20
  static TextStyle h4({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 20,
    );
  }

  /// FONT STYLE FOR FONT SIZE 17
  static TextStyle h5({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      // fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 17,
    );
  }

  /// FONT STYLE FOR FONT SIZE 16
  static TextStyle h6({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 16,
    );
  }

  /// FONT STYLE FOR FONT SIZE 15
  static TextStyle t1({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 15,
    );
  }

  /// FONT STYLE FOR FONT SIZE 14
  static TextStyle t2({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14,
    );
  }

  /// FONT STYLE FOR FONT SIZE 13
  static TextStyle t3({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 13,
    );
  }

  /// FONT STYLE FOR FONT SIZE 12
  static TextStyle t4({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 12,
    );
  }

  /// FONT STYLE FOR FONT SIZE 11
  static TextStyle t5({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 11,
    );
  }

  /// FONT STYLE FOR FONT SIZE 14
  static TextStyle l1({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14,
    );
  }

  /// FONT STYLE FOR FONT SIZE 14
  static TextStyle p1({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14,
    );
  }

  /// FONT STYLE FOR FONT SIZE 13
  static TextStyle p2({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 13,
    );
  }

  /// FONT STYLE FOR FONT SIZE 12
  static TextStyle p3({
    Color? fontColor,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'Master',
      color: fontColor ?? AppColors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 12,
    );
  }
}
