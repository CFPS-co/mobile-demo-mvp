import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/create_password/cubit/create_password_cubit.dart';
import 'package:cfps/app/pages/login_with_pin_code/utils/login_with_pin_code_type.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/enums/validators.dart';
import 'package:cfps/app/utils/extensions/validation_extension.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/utils/widgets/password_text_field.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_top_snackbar.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CreatePasswordPage extends HookWidget {
  const CreatePasswordPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: BlocProvider(
          create: (context) => getIt<CreatePasswordCubit>(),
          child: BlocListener<CreatePasswordCubit, CreatePasswordState>(
            listener: (context, state) => state.whenOrNull(
              fail: (failure) {
                if (failure.content != null) {
                  showAppTopSnackBar(context, failure.content!);
                }
                return null;
              },
              saved: () => context.router.push(
                LoginWithPinCodeRoute(
                  loginType: LoginWithPinType.setPin,
                  nextRoute: const CountryRoute(),
                ),
              ),
            ),
            child: _CreatePasswordForm(email: email),
          ),
        ),
      );
}

class _CreatePasswordForm extends HookWidget {
  const _CreatePasswordForm({Key? key, required this.email}) : super(key: key);
  final String email;
  static const padding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    var isPasswordVisible = useState<bool>(false);
    var isConfirmationPasswordVisible = useState<bool>(false);

    var passwordController = useTextEditingController();
    var passwordConfirmationController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocBuilder<CreatePasswordCubit, CreatePasswordState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.blueDianne)),
          orElse: () => CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: padding,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.of(context).createPassword,
                          style: getIt<ThemeManager>().textStyles.headline1,
                          textAlign: TextAlign.left,
                        ),
                        const Gap(32),
                        Text(
                          Translation.of(context).createPasswordDescription,
                          style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(color: AppColors.holly40),
                          textAlign: TextAlign.left,
                        ),
                        const Gap(24),
                        PasswordTextFormField(
                          isPasswordVisible: isPasswordVisible,
                          textEditingController: passwordController,
                          label: Translation.of(context).createPassword,
                          textFormFieldValidator: (String? value) =>
                              Validators.validatePassword(value)?.message(context),
                        ),
                        const Gap(16),
                        PasswordTextFormField(
                          isPasswordVisible: isConfirmationPasswordVisible,
                          textEditingController: passwordConfirmationController,
                          label: Translation.of(context).confirmPassword,
                          textFormFieldValidator: (String? value) =>
                              Validators.validateConfirmPassword(value, passwordController.text)?.message(context),
                        ),
                        const Gap(32),
                        const Spacer(),
                        AppButton(
                          Translation.of(context).theContinue,
                          style: getIt<ThemeManager>().buttonStyles.roundedButton,
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<CreatePasswordCubit>().saveCredentials(passwordController.text, email);
                            }
                          },
                          height: 56,
                        ),
                        const Gap(16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
