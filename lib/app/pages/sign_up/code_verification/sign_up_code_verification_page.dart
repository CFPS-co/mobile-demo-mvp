import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/sign_up/code_verification/cubit/sign_up_code_verification_cubit.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/regular_expressions.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/domain/entities/sign_up_arguments.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SignUpCodeVerificationPage extends HookWidget {
  const SignUpCodeVerificationPage({super.key, required this.arguments});

  static const _buttonHeight = 56.0;
  static const _padding = EdgeInsets.all(16.0);

  final SignUpArguments arguments;

  @override
  Widget build(BuildContext context) {
    final code = useState<String>('');
    final controller = useTextEditingController();
    final error = useState<bool>(false);
    return BlocProvider(
      create: (context) => getIt<SignUpCodeVerificationCubit>(),
      child: BlocListener<SignUpCodeVerificationCubit, SignUpCodeVerificationState>(
        listener: (context, state) => state.whenOrNull(
          codeMismatch: () {
            code.value = '';
            controller.clear();
            error.value = true;
            return;
          },
          tooManyAttempts: () => context.router.pop(),
          onSuccess: (arguments) => context.router.push(CreatePasswordRoute(email: arguments.email)),
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
              child: Padding(
                padding: _padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translation.of(context).verifyYourEmail,
                      style: getIt<ThemeManager>().textStyles.headline1,
                    ),
                    const Gap(16),
                    RichText(
                      text: TextSpan(
                        text: Translation.of(context).checkYourEmail,
                        style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(color: AppColors.edward),
                        children: [
                          TextSpan(
                            text: arguments.email,
                            style: getIt<ThemeManager>().textStyles.bodyText2Medium.copyWith(color: AppColors.edward),
                          ),
                          TextSpan(
                            text: Translation.of(context).checkYourEmailContinued,
                            style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(color: AppColors.edward),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          _CodeDots(code, controller),
                          const Gap(4),
                          error.value
                              ? Text(
                                  Translation.of(context).codeMismatch,
                                  style: getIt<ThemeManager>()
                                      .textStyles
                                      .bodyText2Medium
                                      .copyWith(color: AppColors.bitterSweet),
                                )
                              : const Gap(16)
                        ],
                      ),
                    ),
                    const Spacer(flex: 4),
                    SizedBox(
                      height: _buttonHeight,
                      child: AppButton(
                        Translation.of(context).theContinue,
                        style: getIt<ThemeManager>().buttonStyles.roundedButton,
                        onPressed: code.value.length == 6
                            ? () {
                                context.read<SignUpCodeVerificationCubit>().verifyCode(
                                      arguments: arguments,
                                      enteredCode: code.value,
                                    );
                              }
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CodeDots extends HookWidget {
  const _CodeDots(this.code, this.controller);

  static const String _hint = '• • • • • •';

  final ValueNotifier<String> code;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .60,
      child: TextField(
        textAlign: TextAlign.center,
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(RegularExpressions.digitsOnlyRegExp),
          )
        ],
        maxLength: 6,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        showCursor: false,
        autofocus: true,
        keyboardType: TextInputType.number,
        style: getIt<ThemeManager>().textStyles.headline1.copyWith(
              letterSpacing: 16,
            ),
        onChanged: (value) => code.value = value,
        controller: controller,
        decoration: InputDecoration(
          hintText: _hint,
          counterText: '',
          hintStyle: getIt<ThemeManager>().textStyles.headline1.copyWith(
                fontSize: 40,
                letterSpacing: 3,
              ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
