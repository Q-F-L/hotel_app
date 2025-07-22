part of '../themes.dart';

const titleLarge = TextStyle(
  fontFamily: 'Philosopher',
  color: AppColors.black,
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);
const bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 59, 59, 59),
    fontFamily: "Philosopher");
const inputText = TextStyle(
  color: Color.fromARGB(255, 164, 165, 167),
  fontFamily: "Philosopher",
  fontSize: 14,
);
const datePickerText = TextStyle(
  color: AppColors.black,
  fontSize: 16,
);
const datePickerDisabelText = TextStyle(
  color: Color.fromARGB(109, 88, 88, 88),
  fontSize: 17,
);
const whiteTextButton = TextStyle(
  fontFamily: 'Philosopher',
  color: Color(0xFFFEFEFF),
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);
const titleSmall = TextStyle(
    fontSize: 20,
    color: Color.fromARGB(255, 59, 59, 59),
    fontFamily: "Philosopher");
const headline2_regular = TextStyle(
  fontFamily: "Philosopher",
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: AppColors.black,
);
const headline3_regular = TextStyle(
    fontFamily: "Philosopher",
    fontWeight: FontWeight.w800,
    fontSize: 16,
    color: AppColors.black);

const labelSmall = TextStyle(
    fontFamily: "Philosopher",
    fontWeight: FontWeight.w100,
    fontSize: 14,
    color: AppColors.black);

const bodySmall = TextStyle(
    fontFamily: "Philosopher",
    fontWeight: FontWeight.w100,
    fontSize: 16,
    color: AppColors.black);

const link = TextStyle(
    fontFamily: "Philosopher",
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.lightGreen);

const labelSmallManrope = TextStyle(
    fontFamily: "Manrope",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.realBlack);

class AppColors {
  // LightTheme
  static const backgroundWhite = Color(0xFAFDFFFF);
  static const white = Colors.white;
  static const textWhite = Color(0xFFFEFEFF);
  static const inputWhite = Color(0xF4F4F4F4);
  static const grey = Color.fromARGB(255, 59, 59, 59);
  static const grey1 = Color.fromARGB(58, 114, 114, 114);
  static const whiteBorder = Color(0xF4F4F4F4);
  static const black = Color.fromARGB(255, 59, 59, 59);
  static const realBlack = Colors.black;
  static const lightGreen = Color.fromARGB(255, 27, 194, 122);
  static const textGreen = Color.fromARGB(255, 71, 179, 111);
  static const shadow = Color.fromARGB(40, 90, 108, 234);
  static const lightYellow = Color.fromARGB(255, 255, 237, 144);
  static const yellow = Color.fromARGB(195, 252, 255, 101);
}
