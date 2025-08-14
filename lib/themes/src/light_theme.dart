part of '../themes.dart';

ThemeData createLightTheme() {
  return ThemeData(
    sliderTheme: SliderThemeData(
      trackHeight: 10,
      activeTrackColor: Colors.red,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF6FBFB),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
    ),
    inputDecorationTheme:
        const InputDecorationTheme(fillColor: AppColors.black),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.black,
      onPrimary: AppColors.black,
      secondary: AppColors.grey,
      onSecondary: AppColors.grey,
      surface: AppColors.lightGreen,
      onSurface: AppColors.lightGreen,
      error: AppColors.grey,
      onError: AppColors.grey,
    ),
    scaffoldBackgroundColor: AppColors.backgroundWhite,
    textTheme: const TextTheme(
      bodyLarge: bodyLarge,
      titleLarge: titleLarge,
      titleSmall: titleSmall,
      headlineLarge: headline2_regular,
      bodySmall: bodySmall,
      labelSmall: labelSmall,
      labelMedium: datePickerText,
      labelLarge: datePickerDisabelText,
    ),
  );
}
