import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:get/get.dart';

DatabaseReference allSheetRef = FirebaseDatabase.instance
    .ref('sheets')
    .child(Credentials.userCredentials.branch) //to be changed
    .child('all');

class NormalVolunteer {
  NormalVolunteer({
    required this.phone_text,
    required this.Volname,
    required this.motabaa,
    required this.id,
    required this.months_count,
  });

  String phone_text;
  String Volname;
  String motabaa;
  int id;
  int months_count;

  factory NormalVolunteer.fromSnapshot(dynamic map) {
    // Map<dynamic, dynamic> map =
    //     Map<String, dynamic>.from(snapshot.value! as Map<String, dynamic>);
    return NormalVolunteer(
      phone_text: map['phone_text'] as String,
      Volname: map['Volname'],
      motabaa: map['motabaa'],
      id: map['id'],
      months_count: map['months_count'],
    );
  }

  static Future<void> writeAllSheetToFirebase(
      List<NormalVolunteer> vols) async {
    // Write data to Firebase
    for (NormalVolunteer vol in vols) {
      await allSheetRef.child(vol.id.toString()).set({
        'Volname': vol.Volname,
        'id': vol.id,
        'months_count': vol.months_count,
        'phone_text': vol.phone_text,
        'motabaa': vol.motabaa,
      });
      // print("volunteer ${vol.Volname} added to db");
    }
  }

  static void deleteVolunteer(int volId) {
    allSheetRef.child(volId.toString()).remove().then((value) => Get.snackbar(
          "Deleted",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.offerRed,
        ));
  }

  static Future<void> addVolunteer(
    String phone_text,
    String Volname,
    // String motabaa,
    int id,
    // int months_count,
  ) async {
    await allSheetRef.child(id.toString()).set({
      'Volname': Volname,
      'id': id,
      'months_count': 0,
      'phone_text': phone_text,
      'motabaa': 'داخل المتابعة',
    }).then((value) => Get.snackbar(
          "Added",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.successGreen,
        ));
  }
}
