part of 'styles.dart';

@injectable
class ButtonStyles {
  /// Use with AppButton widget
  ButtonStyle get roundedButton => ButtonStyle(
        enableFeedback: true,
        elevation: MaterialStateProperty.all<double>(0.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) =>
              states.contains(MaterialState.disabled) ? AppColors.defaultInactiveColor : AppColors.defaultActiveColor,
        ),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.black.withOpacity(.2)),
        textStyle: MaterialStateProperty.all<TextStyle>(
          getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(
                color: AppColors.white,
              ),
        ),
      );

  ButtonStyle get secondaryButton => ButtonStyle(
        enableFeedback: true,
        elevation: MaterialStateProperty.all<double>(0.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) =>
              states.contains(MaterialState.disabled) ? AppColors.defaultInactiveColor : AppColors.defaultBackground,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.defaultActiveColor),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.black.withOpacity(.2)),
        textStyle: MaterialStateProperty.all<TextStyle>(
          getIt<ThemeManager>().textStyles.bodyText1Medium,
        ),
      );
  ButtonStyle get roundedButtonWithIcon => ButtonStyle(
        enableFeedback: true,
        elevation: MaterialStateProperty.all<double>(0.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) =>
              states.contains(MaterialState.disabled) ? AppColors.defaultInactiveColor : AppColors.defaultActiveColor,
        ),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.black.withOpacity(.2)),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (states) => states.contains(MaterialState.disabled)
              ? getIt<ThemeManager>().textStyles.avenir16Medium.copyWith(
                    color: AppColors.silverSand,
                  )
              : getIt<ThemeManager>().textStyles.avenir16Medium.copyWith(
                    color: AppColors.white,
                  ),
        ),
      );

  ButtonStyle get textWithIconButton {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(AppColors.defaultActiveColor),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.defaultInactiveColor.withOpacity(0.30)),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(8, 10, 12, 10)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        getIt<ThemeManager>().textStyles.avenir16Medium,
      ),
    );
  }
}
