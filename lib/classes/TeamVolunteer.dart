import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/utility_funcs.dart';
import 'package:get/get.dart';

DatabaseReference teamSheetRef = FirebaseDatabase.instance
    .ref('sheets')
    .child(Credentials.userCredentials.branch) //to be changed
    .child('month_mosharkat');

class TeamVolunteer {
  TeamVolunteer({
    required this.code,
    required this.Volname,
    required this.degree,
  });

  String code;
  String Volname;
  String degree;

  factory TeamVolunteer.fromSnapshot(dynamic map) {
    // Map<dynamic, dynamic> map =
    //     Map<String, dynamic>.from(snapshot.value! as Map<String, dynamic>);
    return TeamVolunteer(
      code: map['code'],
      Volname: map['Volname'],
      degree: map['degree'],
    );
  }

  static Future<void> writeTeamSheetToFirebase(List<TeamVolunteer> vols) async {
    // Write data to Firebase
    for (TeamVolunteer vol in vols) {
      await teamSheetRef.child(vol.Volname).set({
        'Volname': vol.Volname,
        'code': vol.code,
        'degree': vol.degree,
      });
      print("volunteer ${vol.Volname} added to db");
    }
  }

  static void deleteVolunteer(String volName) {
    teamSheetRef.child(volName).remove().then((value) => Get.snackbar(
          "Deleted",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.offerRed,
        ));
  }

  static Future<void> addVolunteer(
    String Volname,
    String degree,
    List<String> allCodes,
  ) async {
    await teamSheetRef.child(Volname).set({
      'Volname': Volname,
      'degree': degree,
      'code': generateVolunteerCode(allCodes),
    }).then((value) => Get.snackbar(
          "Added",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.successGreen,
        ));
  }
}
