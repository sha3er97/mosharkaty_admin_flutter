import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/components/buttons/master_btn.dart';
import 'package:flutter_mosharkaty/res/colors.dart';

class GeneralErrorScreen extends StatelessWidget {
  const GeneralErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_screens/1_No Connection.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: AppColors.grey2,
                  ),
                ],
              ),
              child: MasterButton(
                textColor: AppColors.grey4,
                onTap: () {
                  Navigator.pop(context);
                },
                name: "Retry",
              ),
            ),
          )
        ],
      ),
    );
  }
}
