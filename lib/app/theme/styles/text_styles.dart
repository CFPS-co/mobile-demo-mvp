part of 'styles.dart';

@injectable
class TextStyles {
  static const String avenir = 'Avenir';

  TextStyle get headline1 => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headline2 => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headline3Regular => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      );

  TextStyle get headline3SemiBold => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyText1Regular => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      );

  TextStyle get bodyText1Medium => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bodyText1SemiBold => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyText2Regular => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      );

  TextStyle get bodyText2Medium => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bodyText3Regular => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );

  TextStyle get bodyText3Medium => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      );

  TextStyle get avenir12Medium => const TextStyle(
        fontSize: 12,
        fontFamily: avenir,
        fontWeight: FontWeight.w500,
      );

  TextStyle get avenir16Medium => const TextStyle(
        fontSize: 16,
        fontFamily: avenir,
        fontWeight: FontWeight.w500,
      );

  TextStyle get avenir32Medium => const TextStyle(
        fontSize: 32,
        fontFamily: avenir,
        fontWeight: FontWeight.w500,
      );

  TextStyle get mulish16Bold => TextStyle(
        fontSize: 16,
        fontFamily: GoogleFonts.mulish().fontFamily,
        fontWeight: FontWeight.w700,
      );
}
