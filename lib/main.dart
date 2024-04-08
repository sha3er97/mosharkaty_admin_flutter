import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mosharkaty/classes/admin.dart';
import 'package:flutter_mosharkaty/config.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/themes.dart';
import 'package:flutter_mosharkaty/screens/home_page.dart';
import 'package:flutter_mosharkaty/screens/login.dart';
import 'package:get/get.dart';
import 'package:flutter_mosharkaty/screens/error_success_screens/general_error.dart';
import 'package:flutter_mosharkaty/screens/error_success_screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'classes/credentials.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  // await initialize(); //load initial important data
  runApp(const MyApp());
}

Future<void> initialize() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: configurations.apiKey,
    appId: configurations.appId,
    messagingSenderId: configurations.messagingSenderId,
    projectId: configurations.projectId,
    storageBucket: configurations.storageBucket,
    databaseURL: configurations.databaseUrl,
  ));
  //other initializations
  // await Admin.getAdmin();
}

final configurations = Configurations();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Colors.white,
      //   primarySwatch: Colors.red,
      // ),
      theme: MyTheme.lightTheme,
      home: FutureBuilder(
          // Initialize FlutterFire:
          future: initialize(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print("INIT ERROR : ${snapshot.error}");
              return const GeneralErrorScreen();
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              // return const Login();
              FirebaseAuth.instance.userChanges().listen((User? user) async {
                if (user == null) {
                  print('User is currently signed out!');
                  //go to login screens
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Login()));
                } else {
                  print('User is signed in!');
                  await Credentials.getUserData(user.uid)
                      .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (context) => SuccessScreen()
                              builder: (context) => const HomePage())));
                  // await afterUserLoads();
                  // Credentials.setCredentialsConfig(
                  //     user.email.toString());
                }
              });
              // return SplashScreen();
            }
            // Otherwise, show something whilst waiting for initialization to complete
            return const ColorLoader();
          }
          // home: const HomePage(),
          ),
    );
  }
}
