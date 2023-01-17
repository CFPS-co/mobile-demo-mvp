import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.gr.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/domain/entities/country.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryPicker extends HookWidget {
  const CountryPicker({
    required this.countries,
    required this.selectedCountryNotifier,
    Key? key,
  }) : super(key: key);

  final List<Country> countries;
  final ValueNotifier<Country> selectedCountryNotifier;

  static const _horizontalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    final searchField = useTextEditingController();
    useListenable(searchField);
    useListenable(selectedCountryNotifier);

    final filteredCountries = searchField.text.isNotEmpty
        ? countries.where((country) => country.name.toLowerCase().startsWith(searchField.text.toLowerCase())).toList()
        : countries;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: _HeaderBar(),
              ),
              Expanded(
                child: filteredCountries.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                        children: filteredCountries
                            .map(
                              (country) => _CountryRadioItem(
                                country: country,
                                isActive: country.code == selectedCountryNotifier.value.code,
                                onTap: () {
                                  selectedCountryNotifier.value = country;
                                  getIt<AppRouter>().pop();
                                },
                              ),
                            )
                            .toList(),
                      )
                    : const _CountryNotFound(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding, vertical: 10),
                child: TextField(
                  controller: searchField,
                  style: getIt<ThemeManager>().textStyles.bodyText1Regular,
                  cursorColor: AppColors.holly40,
                  decoration: InputDecoration(
                    hintText: Translation.of(context).search,
                    hintStyle: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(color: AppColors.holly40),
                    prefixIcon: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        ImgPathsSvg.iconSearch,
                        color: AppColors.holly,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    suffixIcon: searchField.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => searchField.text = "",
                            icon: SvgPicture.asset(
                              ImgPathsSvg.iconCircleClose,
                              color: AppColors.holly,
                            ),
                          )
                        : null,
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: AppColors.holly05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountryNotFound extends StatelessWidget {
  const _CountryNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(Translation.of(context).countryNotFound));
  }
}

class _CountryRadioItem extends StatelessWidget {
  const _CountryRadioItem({
    required this.country,
    required this.isActive,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Country country;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              height: 22,
              child: Flag.fromString(country.code),
            ),
            const SizedBox(width: 10),
            Text(
              country.name,
              style: getIt<ThemeManager>().textStyles.bodyText2Regular,
            ),
            const Spacer(),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? AppColors.blueDianne : AppColors.holly40,
                  width: isActive ? 6 : 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Translation.of(context).country,
          style: getIt<ThemeManager>().textStyles.bodyText1Medium,
          textAlign: TextAlign.left,
        ),
        TextButton(
          onPressed: () => getIt<AppRouter>().pop(),
          style: getIt<ThemeManager>().buttonStyles.textWithIconButton.copyWith(
                padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Translation.of(context).cancel,
                style: getIt<ThemeManager>().textStyles.bodyText2Medium,
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(ImgPathsSvg.iconClose, color: AppColors.blueDianne),
            ],
          ),
        ),
      ],
    );
  }
}
