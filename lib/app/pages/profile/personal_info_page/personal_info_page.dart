import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  static const listPadding = EdgeInsets.all(16);

  static String mockFirstName = "Kate";
  static String mockLastName = "Pauers";
  static String mockDateOfBirth = "09/12/1990";
  static String mockAddressLine1 = "United Kingdom, London";
  static String mockAddressLine2 = "304 Queensway\nWOLVERHAMPTON ";
  static String mockEmail = "kate@gmail.com";
  static String mockPhoneNumber = "+4 (020) 123-4567";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: ListView(
        padding: listPadding,
        children: [
          Text(
            Translation.of(context).personalInfo,
            style: getIt<ThemeManager>().textStyles.headline1,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 32),
          PersonalDetailsItem(
            title: Translation.of(context).firstName,
            value: mockFirstName,
            onTap: () => goToInformationChage(context),
          ),
          PersonalDetailsItem(
            title: Translation.of(context).lastName,
            value: mockLastName,
            onTap: () => goToInformationChage(context),
          ),
          PersonalDetailsItem(
            title: Translation.of(context).dateOfBirth,
            value: mockDateOfBirth,
            onTap: () => goToInformationChage(context),
          ),
          PersonalDetailsItem(
            title: Translation.of(context).addressLine1,
            value: mockAddressLine1,
            onTap: () => goToInformationChage(context),
          ),
          PersonalDetailsItem(
            title: Translation.of(context).addressLine2,
            value: mockAddressLine2,
            onTap: () => goToInformationChage(context),
          ),
          PersonalDetailsItem(
            title: Translation.of(context).email,
            value: mockEmail,
            onTap: () => goToInformationChage(context),
          ),
          PersonalDetailsItem(
            title: Translation.of(context).phoneNumber,
            value: mockPhoneNumber,
            onTap: () => goToInformationChage(context),
          ),
        ],
      ),
    );
  }

  void goToInformationChage(BuildContext context) {
    context.router.push(const PersonalInfoConfirmationRoute());
  }
}

class PersonalDetailsItem extends StatelessWidget {
  const PersonalDetailsItem({super.key, required this.title, required this.value, required this.onTap});

  final String title;
  final String value;
  final VoidCallback onTap;

  static const verticalMargin = EdgeInsets.symmetric(vertical: 8);
  static const borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: verticalMargin,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.silverSand,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ListTile(
        title: Text(
          title,
          style: getIt<ThemeManager>().textStyles.bodyText3Medium.copyWith(color: AppColors.silverSand),
        ),
        subtitle: Text(
          value,
          style: getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(color: AppColors.black),
        ),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(ImgPathsSvg.iconEdit),
          onPressed: onTap,
        ),
      ),
    );
  }
}
