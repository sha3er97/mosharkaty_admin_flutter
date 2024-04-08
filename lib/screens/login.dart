import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/components/buttons/master_btn.dart';
import 'package:flutter_mosharkaty/components/wave_widget.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/icons.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';
import 'package:flutter_mosharkaty/res/textUtilities.dart';
import 'package:flutter_mosharkaty/res/utility_funcs.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  bool _email_validate = false;
  bool _password_validate = false;
  bool passwordVisible = true;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Center(
              //   child: SizedBox(
              //     width: tightBoxWidth,
              //     height: logoHeight,
              //     child: Image.asset(
              //       'assets/images/icon.png',
              //       height: logoHeight,
              //       fit: BoxFit.scaleDown,
              //     ),
              //     // child: SvgPicture.asset('images/login.svg')
              //   ),
              // ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 375,
                    color: AppColors.newBlueDark,
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutQuad,
                    top: keyboardOpen ? -size.height / 3.7 : 0.0,
                    child: WaveWidget(
                      size: size,
                      yOffset: size.height / 3.0,
                      color: AppColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: tightBoxWidth,
                          height: logoHeight,
                          child: Image.asset(
                            'assets/images/icon.png',
                            height: logoHeight,
                            fit: BoxFit.scaleDown,
                          ),
                          // child: SvgPicture.asset('images/login.svg')
                        ),
                        // Text(
                        //   'Login',
                        //   style: TextStyle(
                        //     color: AppColors.white,
                        //     fontSize: titleFontSize,
                        //     fontWeight: FontWeight.w900,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              //   child: Text(
              //     'Please sign in to continue.',
              //     style: TextStyle(
              //         color: AppColors.newBlueDark,
              //         fontWeight: FontWeight.w400,
              //         fontSize: mediumFontSize),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: minimumPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ///login fields
                      // sBoxHeight30,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: minimumPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'الايميل',
                                style: FontStyleUtilities.h5(
                                    fontWeight: FWT.light,
                                    fontColor: AppColors.newBlueDark),
                              ),
                              sBoxHeight8,
                              TextField(
                                style: (FontStyleUtilities.h5(
                                    fontWeight: FWT.light,
                                    fontColor: AppColors.newBlueDark)),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: AppColors.newBlueDark,
                                obscureText: false,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.newBlueDark,
                                          width: borderWidth),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(defaultPadding))),
                                  errorText: _email_validate
                                      ? 'Email Can\'t Be Empty'
                                      : null,
                                  errorStyle: const TextStyle(
                                      color: AppColors.offerRed),
                                  fillColor:
                                      AppColors.transparent.withOpacity(.05),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    MyIcons.email,
                                    color: AppColors.newBlueDark,
                                  ),
                                  // Image.asset('images/email.png'),
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //       color: AppColors.white,
                                  //       width: borderWidth),
                                  //   borderRadius: BorderRadius.all(
                                  //       Radius.circular(defaultPadding)),
                                  // ),
                                ),
                                onChanged: (value) {
                                  email = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      ////////////////////////////////////////////////////////////////////////////
                      sBoxHeight12,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: minimumPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'كلمة السر',
                                style: FontStyleUtilities.h5(
                                    fontWeight: FWT.light,
                                    fontColor: AppColors.newBlueDark),
                              ),
                              sBoxHeight8,
                              TextFormField(
                                style: (FontStyleUtilities.h5(
                                    fontWeight: FWT.light,
                                    fontColor: AppColors.newBlueDark)),
                                cursorColor: AppColors.newBlueDark,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.newBlueDark),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisible = !passwordVisible;
                                        },
                                      );
                                    },
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.newBlueDark,
                                          width: borderWidth),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(defaultPadding))),
                                  errorText: _password_validate
                                      ? 'Password Can\'t Be Empty'
                                      : null,
                                  errorStyle: const TextStyle(
                                      color: AppColors.offerRed),
                                  fillColor:
                                      AppColors.transparent.withOpacity(.05),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    MyIcons.lock,
                                    color: AppColors.newBlueDark,
                                  ),
                                  // Image.asset('images/email.png'),
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //       color: AppColors.white,
                                  //       width: borderWidth),
                                  //   borderRadius: BorderRadius.all(
                                  //       Radius.circular(defaultPadding)),
                                  // ),
                                ),
                                onChanged: (value) {
                                  password = value;
                                },
                                onFieldSubmitted: (value) {
                                  ///to login on pressing enter at last field
                                  loginPressed();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(minimumPadding),
                child: Center(
                  child: MasterButton(
                    name: 'دخول',
                    buttonColor: AppColors.newBlueDark,
                    onTap: () async {
                      await loginPressed();
                    },
                  ),
                ),
              ),
              sBoxHeight16,
              const Center(
                child: Text(
                  'Version : $versionNum',
                  style: TextStyle(color: AppColors.newBlueDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginPressed() async {
    setState(() {
      _email_validate = emptyField(email);
      _password_validate = emptyField(password);
    });
    if (!_email_validate && !_password_validate) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
      } on FirebaseAuthException catch (e) {
        // print("             Error:" + e.code);
        Get.snackbar(
          "Login Error",
          getMessageFromErrorCode(e.code),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.offerRed,
        );
      }
      // if (isAdmin(email, password)) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           // builder: (context) => SuccessScreen()
      //           builder: (context) => const HomePage()));
      // } else {
      //   Get.snackbar(
      //     "email or password not correct",
      //     "try again",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: AppColors.offerRed,
      //   );
      // }
    }
  }
}
