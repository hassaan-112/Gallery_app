// Replace your existing AppTheme with this version that uses safe fallback colors:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/res/colors/appColors.dart';

abstract class AppTheme {
  static const _primaryColor = AppColors.primary;
  static const _secondaryColor = AppColors.secondaryWhite;
  static const _borderRadius = 12.0;
  static const _buttonPadding = EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 20,
  );

  // SAFE FALLBACK COLORS - Replace these with your actual colors once we identify the issue
  static const Color _safeTextDarkColor = Colors.black87;
  static const Color _safeTextLightColor = Colors.white;
  static const Color _safeLightBg = Colors.white;
  static const Color _safeDarkBg = Color(0xff1B1C1E);

  static const Color _lightContainerColor = AppColors.secondaryWhite;
  static const Color _darkContainerColor = AppColors.darkBgColor;

  static const Color _lightScaffoldColor = AppColors.secondaryWhite;
  static const Color _darkScaffoldColor = Color(0xff1B1C1E);

  static final ThemeData lightTheme = ThemeData(
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _lightScaffoldColor,
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
      onPrimary: Colors.white,
      onSecondary: _safeTextDarkColor,
      surface: _safeLightBg,
      onSurface: _safeTextDarkColor,
    ),
    appBarTheme: _appBarTheme(_primaryColor, _safeTextLightColor),
    textTheme: _lightTextTheme,
    cardColor: _lightContainerColor,
    elevatedButtonTheme: _elevatedButtonTheme(Brightness.light),
    inputDecorationTheme: _inputDecorationTheme(
      AppColors.secondaryWhite,
      Colors.grey[600]!, // Safe fallback for hint color
    ),
    iconTheme: IconThemeData(color: _primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(
      AppColors.bgColor,
      _primaryColor,
      _safeTextDarkColor,
    ),
    switchTheme: _switchTheme(_primaryColor),
    checkboxTheme: _checkboxTheme(_primaryColor),
    sliderTheme: _sliderTheme(_primaryColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: _primaryColor),
    dividerTheme: DividerThemeData(
      color: Colors.grey[400],
      thickness: 1,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _darkScaffoldColor,
    colorScheme: ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
      onPrimary: Colors.white,
      onSecondary: _safeTextLightColor,
      surface: _safeDarkBg,
      onSurface: _safeTextLightColor,
    ),
    appBarTheme: _appBarTheme(
      AppColors.secondaryBlack,
      _safeTextLightColor,
    ),
    textTheme: _darkTextTheme,
    cardColor: _darkContainerColor,
    elevatedButtonTheme: _elevatedButtonTheme(Brightness.dark),
    inputDecorationTheme: _inputDecorationTheme(
      AppColors.secondaryBlack,
      Colors.grey[400]!, // Safe fallback for hint color
    ),
    iconTheme: IconThemeData(color: Colors.white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(
      AppColors.secondaryBlack,
      _primaryColor,
      _safeTextLightColor,
    ),
    switchTheme: _switchTheme(_primaryColor),
    checkboxTheme: _checkboxTheme(_primaryColor),
    sliderTheme: _sliderTheme(_primaryColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: _primaryColor),
    dividerTheme: DividerThemeData(
      color: Colors.grey[600],
      thickness: 1,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    ),
  );

  static AppBarTheme _appBarTheme(Color bgColor, Color fgColor) => AppBarTheme(
    backgroundColor: bgColor,
    foregroundColor: fgColor,
    elevation: 3,
    titleTextStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: fgColor,
      fontFamily: "Poppins",
    ),
  );

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      Color bgColor,
      Color selected,
      Color unselected,
      ) => BottomNavigationBarThemeData(
    backgroundColor: bgColor,
    selectedItemColor: selected,
    unselectedItemColor: unselected,
  );

  // SAFE TEXT THEMES
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    displayMedium: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.normal,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    displaySmall: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    headlineLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    headlineMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      color: _safeTextDarkColor,
      fontFamily: "Poppins",
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    displayMedium: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.normal,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    displaySmall: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    headlineLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    headlineMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      color: _safeTextLightColor,
      fontFamily: "Poppins",
    ),
  );

  static ElevatedButtonThemeData _elevatedButtonTheme(Brightness brightness) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: brightness == Brightness.dark
            ? AppColors.borderGrey
            : _primaryColor,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        padding: _buttonPadding,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(
      Color fillColor,
      Color hintColor,
      ) => InputDecorationTheme(
    filled: true,
    fillColor: fillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _primaryColor, width: 2),
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
    hintStyle: TextStyle(
      color: hintColor,
      fontFamily: "Poppins",
    ),
  );

  static SwitchThemeData _switchTheme(Color activeColor) => SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color>(
          (states) =>
      states.contains(WidgetState.selected) ? activeColor : Colors.grey,
    ),
    thumbColor: WidgetStateProperty.all(Colors.white),
  );

  static CheckboxThemeData _checkboxTheme(Color activeColor) =>
      CheckboxThemeData(
        checkColor: WidgetStateProperty.all(Colors.white),
        fillColor: WidgetStateProperty.all(activeColor),
      );

  static SliderThemeData _sliderTheme(Color activeColor) => SliderThemeData(
    activeTrackColor: activeColor,
    inactiveTrackColor: activeColor.withValues(alpha:0.5),
    thumbColor: activeColor,
    overlayColor: activeColor.withValues(alpha:0.2),
    valueIndicatorColor: activeColor,
  );
}