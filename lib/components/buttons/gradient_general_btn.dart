import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';

class GradientGeneralButton extends StatelessWidget {
  const GradientGeneralButton({
    required this.gradientColor1,
    required this.gradientColor2,
    // required this.mainColor,
    required this.title,
    required this.param_onPressed,
    required this.btn_icon,
  });

  final Color gradientColor1;
  final Color gradientColor2;
  // final Color mainColor;
  final String title;
  final VoidCallback param_onPressed;
  final IconData btn_icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(minimumPadding),
      child: Center(
        child: ElevatedButton(
          onPressed: param_onPressed,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(boxImageBorder))),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradientColor1, gradientColor2],
                  begin: Alignment.topLeft,
                  end: const Alignment(0.99, 0.0),
                ),
                borderRadius: BorderRadius.circular(boxImageBorder)),
            child: Container(
              width: tightBoxWidth,
              height: regularBoxHeight,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    btn_icon,
                    color: AppColors.white,
                    size: smallIconSize,
                  ),
                  sBoxWidth8,
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "Avenir",
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Center(
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(boxImageBorder),
      //     child: ConstrainedBox(
      //       constraints: BoxConstraints.tightFor(
      //           width: tightBoxWidth, height: regularBoxHeight),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment(0.99, 0.0),
      //             // 10% of the width, so there are ten blinds.
      //             colors: [gradientColor1, gradientColor2],
      //             // red to yellow
      //             tileMode:
      //                 TileMode.repeated, // repeats the gradient over the canvas
      //           ),
      //         ),
      //         child: ElevatedButton.icon(
      //           label: Text(title),
      //           style: ElevatedButton.styleFrom(
      //             textStyle: TextStyle(
      //               fontFamily: "Avenir",
      //               color: AppColors.white,
      //               fontSize: 20,
      //             ),
      //             // TextStyle(fontSize: largeFontSize, fontFamily: 'MyFont'),
      //             padding: EdgeInsets.symmetric(
      //                 horizontal: defaultPadding, vertical: minimumPadding),
      //             backgroundColor: mainColor,
      //           ),
      //           icon: Icon(
      //             btn_icon,
      //             color: AppColors.white,
      //             size: smallIconSize,
      //           ),
      //           onPressed: param_onPressed,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
