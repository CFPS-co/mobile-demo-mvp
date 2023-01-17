import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/regulations/regulations_page.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/enums/validators.dart';
import 'package:cfps/app/utils/extensions/validation_extension.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/regular_expressions.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_checkbox.dart';
import 'package:cfps/app/widget/app_text_field.dart';
import 'package:cfps/domain/entities/sign_up_arguments.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'cubit/sign_up_email_cubit.dart';

class SignUpEmailPage extends HookWidget {
  const SignUpEmailPage({Key? key}) : super(key: key);

  static const _buttonHeight = 56.0;
  static const _padding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    final termsAndConditionsCheckbox = useState<bool>(false);
    final privacyPolicyCheckbox = useState<bool>(false);
    final emailError = useState<ValidationError?>(null);
    final emailFieldController = useTextEditingController();
    return BlocProvider(
      create: (context) => getIt<SignUpEmailCubit>(),
      child: BlocListener<SignUpEmailCubit, SignUpEmailState>(
        listener: (context, state) => state.whenOrNull(
          onSuccess: (verificationCode, email) => context.router.push(
            SignUpCodeVerificationRoute(
              arguments: SignUpArguments(
                verificationCode: verificationCode,
                email: email,
              ),
            ),
          ),
          onError: () => emailError.value = ValidationError.invalidEmail,
          clientAlreadyRegistered: () => emailError.value = ValidationError.emailTaken,
        ),
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              elevation: 0,
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
                onPressed: () => context.router.pop(),
              ),
            ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: _padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translation.of(context).whatsYourEmail,
                            style: getIt<ThemeManager>().textStyles.headline1,
                          ),
                          const Gap(32),
                          AppTextField(
                            title: Translation.of(context).email,
                            controller: emailFieldController,
                            errorText: emailError.value != null ? emailError.value!.message(context) : null,
                          ),
                          const Gap(32),
                          const Spacer(),
                          Row(
                            children: [
                              AppCheckbox(
                                onChanged: (value) => termsAndConditionsCheckbox.value = value,
                                isChecked: termsAndConditionsCheckbox.value,
                              ),
                              const Gap(8),
                              InkWell(
                                onTap: () => context.router.push(
                                  RegulationsRoute(
                                    type: RegulationsType.termsAndConditions,
                                  ),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: '${Translation.of(context).iAcceptCFPS} ',
                                    style: getIt<ThemeManager>()
                                        .textStyles
                                        .bodyText3Medium
                                        .copyWith(color: AppColors.black),
                                    children: [
                                      TextSpan(
                                        text: Translation.of(context).termsAndConditions,
                                        style: getIt<ThemeManager>().textStyles.bodyText3Medium.copyWith(
                                              color: AppColors.defaultActiveColor,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              AppCheckbox(
                                onChanged: (value) => privacyPolicyCheckbox.value = value,
                                isChecked: privacyPolicyCheckbox.value,
                              ),
                              const Gap(8),
                              InkWell(
                                onTap: () => context.router.push(
                                  RegulationsRoute(type: RegulationsType.privacyPolicy),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: '${Translation.of(context).iAcceptCFPS} ',
                                    style: getIt<ThemeManager>()
                                        .textStyles
                                        .bodyText3Medium
                                        .copyWith(color: AppColors.black),
                                    children: [
                                      TextSpan(
                                        text: Translation.of(context).privacyPolicy,
                                        style: getIt<ThemeManager>().textStyles.bodyText3Medium.copyWith(
                                              color: AppColors.defaultActiveColor,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(24),
                          SizedBox(
                            height: _buttonHeight,
                            child: AppButton(
                              Translation.of(context).theContinue,
                              style: getIt<ThemeManager>().buttonStyles.roundedButton,
                              onPressed: termsAndConditionsCheckbox.value && privacyPolicyCheckbox.value
                                  ? () {
                                      validateEmailLocallyAndContinue(
                                        context: context,
                                        email: emailFieldController.value.text,
                                        emailError: emailError,
                                      );
                                    }
                                  : null,
                            ),
                          ),
                          const Gap(16),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateEmailLocallyAndContinue({
    required BuildContext context,
    required String email,
    required ValueNotifier<ValidationError?> emailError,
  }) {
    emailError.value = _emailValidator(email);
    emailError.value != null ? null : context.read<SignUpEmailCubit>().checkEmail(email);
  }

  ValidationError? _emailValidator(String value) {
    if (value.isEmpty) {
      return ValidationError.invalidEmail;
    } else {
      bool emailValid = RegExp(RegularExpressions.emailValidationRegExp).hasMatch(value);
      return emailValid ? null : ValidationError.invalidEmail;
    }
  }
}
