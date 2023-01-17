import 'package:cfps/app/theme/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

import 'app_colors.dart';

@injectable
class ThemeManager {
  const ThemeManager(this.textStyles, this.buttonStyles);

  final TextStyles textStyles;
  final ButtonStyles buttonStyles;

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.defaultBackground,
        // disabledColor: AppColors.disabledBlack,
        primaryColor: AppColors.white,
        // toggleableActiveColor: AppColors.curiousBlue,
        fontFamily: GoogleFonts.inter().fontFamily,
        // dividerTheme: const DividerThemeData(
        //   color: AppColors.riverBed,
        //   thickness: 1,
        // ),
        primaryTextTheme: TextTheme(
          button: TextStyle(
            color: AppColors.black,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
          bodyText1: textStyles.bodyText1Regular,
          bodyText2: textStyles.bodyText2Regular,
          headline1: textStyles.headline1,
          headline2: textStyles.headline2,
          headline3: textStyles.headline3Regular,
          // appBarTheme: const AppBarTheme(
          //   color: AppColors.codGray,
          //   elevation: 0,
          //   iconTheme: IconThemeData(color: AppColors.white),
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //     statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          //     statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          //   ),
          //   titleTextStyle: TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.w500,
          //     color: AppColors.whiteLilac,
          //   ),
          // ),
          // bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.codGray),
          // chipTheme: const ChipThemeData(
          //   backgroundColor: AppColors.charade,
          //   brightness: Brightness.dark,
          //   disabledColor: AppColors.black,
          //   labelStyle: TextStyle(color: AppColors.white),
          //   padding: EdgeInsets.all(padding4),
          //   secondaryLabelStyle: TextStyle(),
          //   secondarySelectedColor: AppColors.curiousBlue,
          //   selectedColor: AppColors.curiousBlue,
          //   showCheckmark: false,
          // ),
          // textButtonTheme: TextButtonThemeData(
          //   style: ButtonStyle(
          //     padding: MaterialStateProperty.all(
          //       const EdgeInsets.symmetric(vertical: height14),
          //     ),
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     minimumSize: MaterialStateProperty.all(const Size(10, 10)),
          //     textStyle: MaterialStateProperty.all(
          //       TextStyle(
          //         color: AppColors.white,
          //         fontFamily: GoogleFonts.mukta().fontFamily,
          //       ),
          //     ),
          //   ),
          // ),
          // inputDecorationTheme: const InputDecorationTheme(
          //   isDense: true,
          //   fillColor: AppColors.charade,
          //   floatingLabelBehavior: FloatingLabelBehavior.never,
          //   contentPadding: EdgeInsets.symmetric(
          //     horizontal: padding16,
          //     vertical: padding12,
          //   ),
          //   disabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(borderRadius20)),
          //     borderSide: BorderSide.none,
          //   ),
          //   enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(borderRadius20)),
          //     borderSide: BorderSide.none,
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(borderRadius20)),
          //     borderSide: BorderSide.none,
          //   ),
          //   border: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(borderRadius20)),
          //     borderSide: BorderSide.none,
          //   ),
          // ),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ButtonStyle(
          //     elevation: MaterialStateProperty.all(0),
          //     backgroundColor: MaterialStateProperty.all(AppColors.curiousBlue),
          //     shape: MaterialStateProperty.all(
          //       const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(borderRadius20)),
          //         side: BorderSide.none,
          //       ),
          //     ),
          //     padding: MaterialStateProperty.all(
          //       const EdgeInsets.all(height12),
          //     ),
          //     textStyle: MaterialStateProperty.all(
          //       TextStyle(
          //         color: AppColors.white,
          //         fontSize: size16,
          //         fontWeight: FontWeight.w600,
          //         fontFamily: GoogleFonts.mukta().fontFamily,
          //       ),
          //     ),
          //   ),
          // ),
          // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          //   selectedLabelStyle: TextStyle(fontSize: size0),
          //   backgroundColor: AppColors.codGray,
          // ),
        ),
      );
}
