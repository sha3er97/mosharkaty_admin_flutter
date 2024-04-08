import 'package:firebase_database/firebase_database.dart';

class Admin {
  String password; // باسوورد موحد
  // اكونتات الفروع
  String mohandseen;
  String maadi;
  String faisal;
  String mnasr;
  String msrelgdida;
  String october;
  String helwan;
  String alex;
  String mokattam;
  String mrkzy;

  ///data holder
  static Admin adminDetails = dummyAdmin;

  Admin(
      {required this.password,
      required this.mohandseen,
      required this.maadi,
      required this.faisal,
      required this.mnasr,
      required this.msrelgdida,
      required this.october,
      required this.helwan,
      required this.alex,
      required this.mokattam,
      required this.mrkzy});

  factory Admin.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> map =
        Map<String, dynamic>.from(snapshot.value! as Map<String, dynamic>);
    return Admin(
      password: map['password'],
      mohandseen: map['mohandseen'],
      maadi: map['maadi'],
      faisal: map['faisal'],
      mnasr: map['mnasr'],
      msrelgdida: map['msrelgdida'],
      october: map['october'],
      helwan: map['helwan'],
      alex: map['alex'],
      mokattam: map['mokattam'],
      mrkzy: map['mrkzy'],
    );
  }

  static Admin get dummyAdmin => Admin(
      password: 'password',
      mohandseen: 'mohandseen',
      maadi: 'maadi',
      faisal: 'faisal',
      mnasr: 'mnasr',
      msrelgdida: 'msrelgdida',
      october: 'october',
      helwan: 'helwan',
      alex: 'alex',
      mokattam: 'mokattam',
      mrkzy: 'mrkzy');

  static getAdmin() async {
    DatabaseEvent event =
        await FirebaseDatabase.instance.ref('AdminAccount').once();
    if (event.snapshot.value != null) {
      adminDetails = Admin.fromSnapshot(event.snapshot);
    } else {
      adminDetails = dummyAdmin;
      print("error fetching admin details");
    }
  }
}
