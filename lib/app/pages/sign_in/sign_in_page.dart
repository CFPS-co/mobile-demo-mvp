import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/login_with_pin_code/utils/login_with_pin_code_type.dart';
import 'package:cfps/app/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/enums/validators.dart';
import 'package:cfps/app/utils/extensions/validation_extension.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/utils/widgets/new_app_text_field.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  static const _padding = EdgeInsets.all(20.0);

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState<bool>(false);
    final passwordError = useState<ValidationError?>(null);
    final emailError = useState<ValidationError?>(null);
    final email = useState<String>('');
    final password = useState<String>('');

    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) => state.whenOrNull(
          initial: () {
            passwordError.value = null;
            emailError.value = null;
            return null;
          },
          userNotExist: () => emailError.value = ValidationError.userNotFound,
          wrongPassword: () => passwordError.value = ValidationError.passwordsNotMatch,
          success: () => context.pushRoute(
            LoginWithPinCodeRoute(loginType: LoginWithPinType.setPin, nextRoute: const HomeRoute()),
          ),
        ),
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              elevation: 0,
              leading: context.router.canPop()
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
                      onPressed: () => context.router.pop(),
                    )
                  : null,
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: _padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.of(context).welcomeBack,
                          style: getIt<ThemeManager>().textStyles.headline1,
                          textAlign: TextAlign.left,
                        ),
                        const Gap(32),
                        NewAppTextField(
                          errorText: emailError.value?.message(context),
                          onChanged: (value) => email.value = value,
                          label: Translation.of(context).email,
                        ),
                        const Gap(16),
                        NewAppTextField(
                          onChanged: (value) => password.value = value,
                          errorText: passwordError.value?.message(context),
                          obscureText: !isPasswordVisible.value,
                          label: Translation.of(context).password,
                          suffixIcon: IconButton(
                            onPressed: () => isPasswordVisible.value = !isPasswordVisible.value,
                            icon: !isPasswordVisible.value
                                ? SvgPicture.asset(ImgPathsSvg.iconHiddenEye)
                                : SvgPicture.asset(ImgPathsSvg.iconEye),
                          ),
                        ),
                        const Gap(32),
                        const Spacer(),
                        AppButton(
                          Translation.of(context).logIn,
                          style: getIt<ThemeManager>().buttonStyles.roundedButton,
                          onPressed: email.value.isNotEmpty && password.value.isNotEmpty
                              ? () => context.read<SignInCubit>().signIn(
                                    email.value,
                                    password.value,
                                  )
                              : null,
                          height: 56,
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
    );
  }
}
