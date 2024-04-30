import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_mosharkaty/res/constants.dart';

class Credentials {
  String branch;
  bool isMrkzy;

  ///data holder
  static Credentials userCredentials =
      Credentials(branch: branches[BRANCHES_COUNT], isMrkzy: true);

  Credentials({required this.branch, required this.isMrkzy});

  factory Credentials.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> map =
        Map<String, dynamic>.from(snapshot.value! as Map<String, dynamic>);
    return Credentials(
      branch: map['branch'],
      isMrkzy: map['branch'] == branches[BRANCHES_COUNT],
    );
  }

  static Future<void> getUserData(String token) async {
    DatabaseEvent event =
        await FirebaseDatabase.instance.ref('users').child(token).once();
    if (event.snapshot.value != null) {
      Credentials.userCredentials = Credentials.fromSnapshot(event.snapshot);
    } else {
      Credentials.userCredentials =
          Credentials(branch: branches[BRANCHES_COUNT], isMrkzy: true);
      print("error fetching credentials details");
    }
  }
}
