import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/res/colors.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.newBlueDark,
    brightness:
        Brightness.light, // Change the color of unselected radio buttons
    iconTheme: const IconThemeData(color: AppColors.white),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.newBlueDark, width: 3))),
    buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary, buttonColor: AppColors.white),
    textTheme: Typography(platform: TargetPlatform.android).black,
    scaffoldBackgroundColor: AppColors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              const TextStyle(color: AppColors.white)),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.newBlueDark)),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.white),
    dividerColor: AppColors.offWhite,
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: Colors.white),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.white;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.white;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.white;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.white;
        }
        return null;
      }),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //       overlayColor: MaterialStateColor.resolveWith(
    //         ((states) => ColorUtils.kcCallIconColor.withOpacity(0.2)),
    //       ),
    //       backgroundColor:
    //           MaterialStateProperty.all<Color>(Colors.transparent)),
    // ),
    // cardColor: ColorUtils.kcWhite,
    // dialogBackgroundColor: ColorUtils.kcWhite,
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  // SystemUiOverlayStyle themeModeUi = ThemeMode.system == ThemeMode.dark
  //     ? SystemUiOverlayStyle.dark
  //     : SystemUiOverlayStyle.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  // bool get isSystemUiModeDark => themeModeUi == SystemUiOverlayStyle.dark;

  void toggleTheme(bool isTrue) {
    themeMode = isTrue ? ThemeMode.dark : ThemeMode.light;
    // themeModeUi =
    //     isTrue ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
    notifyListeners();
  }
}
