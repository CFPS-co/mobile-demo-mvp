import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/country/widget/country_picker.dart';
import 'package:cfps/app/pages/kyc/cubit/kyc_cubit.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_select_button.dart';
import 'package:cfps/domain/entities/country.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryPage extends HookWidget {
  const CountryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCountry = useState(countries.first);
    final animationController = useAnimationController(duration: const Duration(milliseconds: 500));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translation.of(context).yourCountry,
              style: getIt<ThemeManager>().textStyles.headline1,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 42),
            AppSelectButton(
              selectedCountry.value.name,
              label: Translation.of(context).country,
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                transitionAnimationController: animationController,
                // useSafeArea: true //This is available on flutter master channel
                builder: (context) {
                  return CountryPicker(countries: countries, selectedCountryNotifier: selectedCountry);
                },
              ),
            ),
            const Spacer(),
            AppButton(
              Translation.of(context).everythingIsCorrect,
              onPressed: () async {
                // TODO delete this later
                // final ds = getIt<MvpLocalDataSource>();
                //
                // await ds.saveEmail("test2@example.com");
                // await ds.saveClientId("213721");
                // await ds.savePassword("1234567t");

                context.read<KycCubit>().startKyc(context);
              },
              style: getIt<ThemeManager>().buttonStyles.roundedButtonWithIcon,
              height: 56,
            )
          ],
        ),
      ),
    );
  }
}

// TODO for demo purpose
final countries = [
  const Country(code: "AT", name: "Austria"),
  const Country(code: "BE", name: "Belgium"),
  const Country(code: "BG", name: "Bulgaria"),
  const Country(code: "HR", name: "Croatia"),
  const Country(code: "CY", name: "Republic of Cyprus"),
  const Country(code: "CZ", name: "Czech Republic"),
  const Country(code: "DE", name: "Denmark"),
  const Country(code: "EE", name: "Estonia"),
  const Country(code: "FI", name: "Finland"),
  const Country(code: "FR", name: "France"),
  const Country(code: "DE", name: "Germany"),
  const Country(code: "GR", name: "Greece"),
  const Country(code: "HU", name: "Hungary"),
  const Country(code: "IE", name: "Ireland"),
  const Country(code: "IT", name: "Italy"),
  const Country(code: "LV", name: "Latvia"),
  const Country(code: "LT", name: "Lithuania"),
  const Country(code: "LU", name: "Luxembourg"),
  const Country(code: "MT", name: "Malta"),
  const Country(code: "NL", name: "Netherlands"),
  const Country(code: "PL", name: "Poland"),
  const Country(code: "PT", name: "Portugal"),
  const Country(code: "R0", name: "Romania"),
  const Country(code: "SK", name: "Slovakia"),
  const Country(code: "SI", name: "Slovenia"),
  const Country(code: "ES", name: "Spain"),
  const Country(code: "SE", name: "Sweden"),
];
