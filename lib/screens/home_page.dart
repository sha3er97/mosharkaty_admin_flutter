import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/components/appBars/common_appbar.dart';
import 'package:flutter_mosharkaty/components/buttons/gradient_general_btn.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';
import 'package:flutter_mosharkaty/res/textUtilities.dart';
import 'package:flutter_mosharkaty/screens/add_new_team.dart';
import 'package:flutter_mosharkaty/screens/add_new_volunteer.dart';
import 'package:flutter_mosharkaty/screens/upload_all_sheet.dart';
import 'package:flutter_mosharkaty/screens/upload_team_codes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      appBar: commonAppBar(context, '', noLead: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "فرع : ${Credentials.userCredentials.branch}",
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: "newJf",
                color: AppColors.mediumBlack,
                fontSize: 15,
              ),
            ),
            sBoxHeight6,
            GradientGeneralButton(
              gradientColor1: AppColors.golden,
              gradientColor2: AppColors.lightBlack,
              // mainColor: AppColors.offWhite,
              title: teamCodes,
              btn_icon: Icons.people,
              param_onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadTeamCodes(),
                  ),
                );
              },
            ),
            ////////////////////////////////////////////////////////
            sBoxHeight6,
            GradientGeneralButton(
              gradientColor1: AppColors.successGreen,
              gradientColor2: AppColors.lightBlack,
              // mainColor: AppColors.offWhite,
              title: allSheet,
              btn_icon: Icons.copy_all_outlined,
              param_onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadAllSheet(),
                  ),
                );
              },
            ),
            ////////////////////////////////////////////////////////
            sBoxHeight6,
            GradientGeneralButton(
              gradientColor1: AppColors.newBlueLight,
              gradientColor2: AppColors.lightBlack,
              // mainColor: AppColors.offWhite,
              title: newVolunteer,
              btn_icon: Icons.add_call,
              param_onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewVolunteer(),
                  ),
                );
              },
            ),
            ////////////////////////////////////////////////////////
            sBoxHeight6,
            GradientGeneralButton(
              gradientColor1: AppColors.offerRed,
              gradientColor2: AppColors.lightBlack,
              // mainColor: AppColors.offWhite,
              title: newTeamVolunteer,
              btn_icon: Icons.add,
              param_onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewTeam(),
                  ),
                );
              },
            ),
            /////////////////////////////////////////////////////////////////////
            sBoxHeight12,
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  print("user logged out from profile");
                  // RouteX.sliderRighToLeft(context, const Intro());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.white)),
                  height: 50,
                  width: 155,
                  child: Center(
                      child: Text(
                    'Log Out',
                    style: FontStyleUtilities.h5(
                        fontColor: AppColors.white, fontWeight: FWT.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
