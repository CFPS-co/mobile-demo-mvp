import 'package:cfps/app/pages/kyc/cubit/kyc_cubit.dart';
import 'package:cfps/app/pages/profile/widgets/app_bar_with_back_button.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KycPage extends StatelessWidget {
  const KycPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButton(),
      body: BlocProvider(
        create: (context) => getIt<KycCubit>(),
        child: Builder(
          builder: (context) {
            return AppButton(
              "Launch KYC",
              style: getIt<ThemeManager>().buttonStyles.roundedButton,
              onPressed: () async {
                context.read<KycCubit>().startKyc(context);
              },
            );
          },
        ),
      ),
    );
  }
}
