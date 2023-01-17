import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/login_with_pin_code/utils/login_with_pin_code_type.dart';
import 'package:cfps/app/pages/login_with_pin_code/widget/pin_keyboard.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/domain/entities/sign_up_arguments.dart';
import 'package:cfps/domain/entities/status_info_page_arguments.dart';
import 'package:cfps/domain/use_case/remove_splash_screen_use_case.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'cubit/login_with_pin_code_cubit.dart';

class LoginWithPinCodePage extends HookWidget {
  const LoginWithPinCodePage({
    super.key,
    required this.loginType,
    this.signUpArguments,
    this.nextRoute,
  });

  final LoginWithPinType loginType;
  final PageRouteInfo? nextRoute;
  final SignUpArguments? signUpArguments;

  @override
  Widget build(BuildContext context) {
    useMemoized(() => getIt<RemoveSplashScreenUseCase>()());

    final enteredPin = useState<String>('');
    return BlocProvider(
      create: (context) => getIt<LoginWithPinCodeCubit>(param1: loginType),
      child: Scaffold(
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
          child: Builder(
            builder: (context) => BlocListener<LoginWithPinCodeCubit, LoginWithPinCodeState>(
              listener: (context, state) {
                enteredPin.value = '';
                state.whenOrNull(
                  auth: (authError) => authError ?? false
                      ? context.read<LoginWithPinCodeCubit>().reset(
                            LoginWithPinType.auth,
                          )
                      : null,
                  pinsDontMatch: () => context.read<LoginWithPinCodeCubit>().reset(
                        LoginWithPinType.changePin,
                      ),
                  newPinSameAsCurrent: () => context.read<LoginWithPinCodeCubit>().reset(
                        LoginWithPinType.changePin,
                      ),
                  onSuccess: () {
                    switch (loginType) {
                      case LoginWithPinType.auth:
                        pushNextRoute(context);
                        break;
                      case LoginWithPinType.changePin:
                        return context.router.push(
                          StatusInfoRoute(
                            arguments: StatusInfoPageArguments(
                              title: Translation.of(context).congrats,
                              subTitle: Translation.of(context).pinChangeSuccess,
                              onPressed: () => context.router.popUntil(
                                (route) => route.settings.name == SettingsRoute.name,
                              ),
                            ),
                          ),
                        );
                      case LoginWithPinType.setPin:
                        pushNextRoute(context);
                        break;
                    }
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _PageTitle(),
                    const Spacer(flex: 2),
                    _PinCodeIndicatorsSection(enteredPin.value),
                    const Gap(8),
                    _PinCodeKeyboard(enteredPin),
                    const Spacer(flex: 1),
                    if (loginType != LoginWithPinType.setPin)
                      _ForgotPassword(onTap: () => context.router.push(const ConfirmPinResetRoute())),
                    const Gap(32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void pushNextRoute(BuildContext context){
    if (nextRoute != null) {
      context.router.push(nextRoute!);
    }
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginWithPinCodeCubit, LoginWithPinCodeState>(
        buildWhen: (p, c) => c.maybeWhen(
          orElse: () => false,
          auth: (_) => true,
          setPin: () => true,
          confirmPin: () => true,
        ),
        builder: (context, state) => state.maybeWhen(
          auth: (_) => Text(
            Translation.of(context).enterYourCurrentPinCode,
            style: getIt<ThemeManager>().textStyles.headline1,
          ),
          setPin: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context).createPin,
                style: getIt<ThemeManager>().textStyles.headline1,
              ),
              const Gap(16),
              Text(
                Translation.of(context).pinWillHelpYouToVerifyTheTransactions,
                style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(color: AppColors.edward),
              )
            ],
          ),
          confirmPin: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context).confirmPin,
                style: getIt<ThemeManager>().textStyles.headline1,
              ),
              const Gap(48),
            ],
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      );
}

class _PinCodeIndicatorsSection extends StatelessWidget {
  const _PinCodeIndicatorsSection(this.enteredPin);

  final String enteredPin;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BlocBuilder<LoginWithPinCodeCubit, LoginWithPinCodeState>(
            builder: (context, state) => state.maybeWhen(
              orElse: () => _PinDots(enteredPin: enteredPin),
              auth: (authError) => _PinDots(
                enteredPin: enteredPin,
                error: authError ?? false,
              ),
              pinsDontMatch: () => _PinDots(
                enteredPin: enteredPin,
                error: true,
              ),
              newPinSameAsCurrent: () => _PinDots(
                enteredPin: enteredPin,
                error: true,
              ),
            ),
          ),
          BlocBuilder<LoginWithPinCodeCubit, LoginWithPinCodeState>(
            builder: (context, state) => state.maybeWhen(
              orElse: () => const Gap(32),
              auth: (authError) =>
                  authError ?? false ? _IndicatorText(Translation.of(context).wrongPinCode) : const Gap(32),
              pinsDontMatch: () => _IndicatorText(
                Translation.of(context).providedPinsDoesNotMatch,
              ),
              newPinSameAsCurrent: () => _IndicatorText(
                Translation.of(context).pinIsTheSameAsTheOldOne,
              ),
            ),
          ),
        ],
      );
}

class _PinCodeKeyboard extends StatelessWidget {
  const _PinCodeKeyboard(this.enteredPin);

  final ValueNotifier<String> enteredPin;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .55,
          child: PinCodeKeyboard(
            isBiometricEnabled: true, //TODO: TBD
            isActive: enteredPin.value.length < 4,
            onTextInput: (codePart) {
              enteredPin.value += codePart;
              if (enteredPin.value.length == 4) {
                context.read<LoginWithPinCodeCubit>().onCodeEntered(enteredPin.value.trim());
              }
            },
            onBackspace: () => enteredPin.value = enteredPin.value.substring(
              0,
              enteredPin.value.isEmpty ? 0 : enteredPin.value.length - 1,
            ),
          ),
        ),
      );
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            Translation.of(context).forgotPinCode,
            style: getIt<ThemeManager>().textStyles.bodyText2Medium.copyWith(
                  color: AppColors.defaultActiveColor,
                ),
          ),
        ),
      );
}

class _IndicatorText extends StatelessWidget {
  const _IndicatorText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Gap(16),
          Text(
            text,
            style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                  color: AppColors.bitterSweet,
                ),
          ),
        ],
      );
}

class _PinDots extends StatelessWidget {
  const _PinDots({
    required this.enteredPin,
    this.error = false,
  });

  static const _pinLength = 4;
  static const _circleSize = 12.0;
  static const _padding = EdgeInsets.symmetric(horizontal: 24.0);

  final String enteredPin;
  final bool error;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _pinLength,
            (index) => Padding(
              padding: _padding,
              child: Container(
                width: _circleSize,
                height: _circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: error
                      ? AppColors.bitterSweet
                      : index < enteredPin.length
                          ? AppColors.black
                          : AppColors.iron,
                ),
              ),
            ),
          ),
        ),
      );
}
