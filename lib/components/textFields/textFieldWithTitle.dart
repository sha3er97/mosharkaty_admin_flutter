import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    Key? key,
    this.title,
    this.prefix,
    this.isObsecure = false,
    this.suffixIcon,
    this.prefixText,
    this.controller,
    this.maxlines = 1,
    this.style,
    this.isPasswordField,
    this.verticalpadding = 11.0,
    this.suffix,
    // this.isnumberinput = false,
    this.keyboardType,
    this.validator,
    this.errorText,
    this.hint,
    this.maxLength,
    this.inputFormatters,
    this.titleStyle,
  }) : super(key: key);
  final bool isObsecure;
  final TextEditingController? controller;
  final String? prefixText;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? title;
  final int? maxlines;
  final TextStyle? style;
  final bool? isPasswordField;
  final double? verticalpadding;

  // final bool? isnumberinput;
  final Widget? prefix;
  final Function(String)? validator;
  final String? errorText;
  final TextInputType? keyboardType;
  final String? hint;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    // var isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          child: (title != null)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(title!,
                          style: titleStyle ??
                              const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Avenir",
                                color: AppColors
                                    .black, //isDark ? kcwhite : Colors.black,
                                fontSize: 13,
                              )),
                      sBoxHeight10
                    ])
              : null,
        ),
        TextField(
          onChanged: validator,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          // onSubmitted: validator,
          keyboardType: keyboardType,
          //isnumberinput! ? TextInputType.number : null,
          style: const TextStyle(fontFamily: "Ansemi").merge(style),
          maxLines: maxlines,
          controller: controller,
          obscuringCharacter: "*",
          obscureText: isObsecure,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.offWhite,
                  //isDark ? kcSmoothBlack : kcdivider,
                  width: 1,
                )),
            fillColor: AppColors.white,
            //isDark ? kcSmoothBlack.withOpacity(0.4) : kcwhite,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.offWhite,
                  //isDark ? kcwhite.withOpacity(0.4) : kcdivider,
                  width: 1,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.newBlueDark,
                  width: 1,
                )),
            prefix: prefix,
            errorText: errorText,
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.grey5),
            suffix: (suffixIcon != null) ? suffixIcon : null,
            suffixIcon: (suffix != null) ? suffix : null,
            contentPadding: EdgeInsets.only(
                top: verticalpadding!, bottom: verticalpadding!, left: 15),
            prefixText: (prefixText != null) ? prefixText : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors
                      .offWhite, //isDark ? kcwhite.withOpacity(0.4) : kcdivider,
                )),
          ),
        ),
        //for passwords

        // SizedBox(
        //   child: (isPasswordField != null)
        //       ? GestureDetector(
        //     onTap: () {},
        //     child: Column(
        //       children: [
        //         const SizedBox(
        //           height: 9,
        //         ),
        //         Container(
        //           alignment: Alignment.topRight,
        //           width: double.infinity,
        //           child: TextButton(
        //             onPressed: () {
        //               RouteX.sliderLeftToRight(
        //                   context, const ForgotPassWord());
        //             },
        //             child: const FoodText.ktsAnreg(
        //               "Forget Password?",
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        //       : null,
        // )
      ],
    );
  }
}
