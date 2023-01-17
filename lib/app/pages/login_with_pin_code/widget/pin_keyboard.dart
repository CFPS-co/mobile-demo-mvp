// ignore_for_file: dead_code

import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PinCodeKeyboard extends StatelessWidget {
  const PinCodeKeyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
    this.isBiometricEnabled = false,
    this.bottomWidget,
    this.isActive = true,
    this.onBiometricTap,
    this.padding,
  }) : super(key: key);
  final Function(String) onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback? onBiometricTap;
  final bool isBiometricEnabled;
  final Widget? bottomWidget;
  final bool isActive;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _PinKeyboardRow(
            first: '1',
            second: '2',
            third: '3',
            onTextInput: isActive ? onTextInput : null,
          ),
          const SizedBox(
            height: 12,
          ),
          _PinKeyboardRow(
            first: '4',
            second: '5',
            third: '6',
            onTextInput: isActive ? onTextInput : null,
          ),
          const SizedBox(
            height: 12,
          ),
          _PinKeyboardRow(
            first: '7',
            second: '8',
            third: '9',
            onTextInput: isActive ? onTextInput : null,
          ),
          const SizedBox(
            height: 12,
          ),
          _PinKeyboardBottomRow(
            isBiometric: isBiometricEnabled,
            onBiometricTap: isActive ? onBiometricTap : null,
            onTextInput: isActive ? onTextInput : null,
            onBackspace: isActive ? onBackspace : null,
          ),
        ],
      ),
    );
  }
}

class _PinKeyboardRow extends StatelessWidget {
  const _PinKeyboardRow({
    Key? key,
    required this.first,
    required this.second,
    required this.third,
    required this.onTextInput,
  }) : super(key: key);
  final String first;
  final String second;
  final String third;
  final Function(String)? onTextInput;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _PinCodeKeyboardNumberBtn(
            text: first,
            onTextInput: onTextInput,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          _PinCodeKeyboardNumberBtn(
            text: second,
            onTextInput: onTextInput,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          _PinCodeKeyboardNumberBtn(
            text: third,
            onTextInput: onTextInput,
          ),
        ],
      ),
    );
  }
}

class _PinKeyboardBottomRow extends StatelessWidget {
  const _PinKeyboardBottomRow({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
    required this.isBiometric,
    this.onBiometricTap,
  }) : super(key: key);
  final Function(String)? onTextInput;
  final VoidCallback? onBackspace;
  final VoidCallback? onBiometricTap;
  final bool isBiometric;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isBiometric)
            _PinCodeKeyboardBiometric(
              onBiometricTap: onBiometricTap,
            )
          else
            const _PinCodeKeyboardEmptyBtn(),
          const Expanded(
            child: SizedBox(),
          ),
          _PinCodeKeyboardNumberBtn(
            text: '0',
            onTextInput: onTextInput,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          _PinCodeKeyboardDeleteBtn(
            onBackspace: onBackspace,
          ),
        ],
      ),
    );
  }
}

class _PinCodeKeyboardNumberBtn extends StatelessWidget {
  const _PinCodeKeyboardNumberBtn({
    Key? key,
    required this.text,
    required this.onTextInput
  }) : super(key: key);
  final String text;
  final dynamic Function(String)? onTextInput;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SizedBox(
        height: 78,
        width: 78,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: AppColors.blackHaze,
            side: const BorderSide(
              color: Colors.transparent,
              width: 0.5,
            ),
          ),
          onPressed:
              onTextInput != null ? () async => onTextInput!(text) : null,
          child: Center(
            child: Text(
              text,
              style: getIt<ThemeManager>()
                  .textStyles
                  .headline1
                  .copyWith(color: AppColors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _PinCodeKeyboardBiometric extends StatelessWidget {
  const _PinCodeKeyboardBiometric({Key? key, required this.onBiometricTap})
      : super(key: key);

  static const _buttonSize = 78.0;

  final VoidCallback? onBiometricTap;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: 4,
        child: SizedBox(
          width: _buttonSize,
          height: _buttonSize,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: onBiometricTap,
            child: Center(
              child: SvgPicture.asset(
                true //TODO: Biometrics TBD
                    ? ImgPathsSvg.iconFaceId
                    : ImgPathsSvg.iconTouchId,
              ),
            ),
          ),
        ),
      );
}

class _PinCodeKeyboardEmptyBtn extends StatelessWidget {
  const _PinCodeKeyboardEmptyBtn({Key? key}) : super(key: key);

  static const _buttonSize = 78.0;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: 4,
        child: Container(
          width: _buttonSize,
          height: _buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.transparent,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(
              '',
              style: getIt<ThemeManager>().textStyles.avenir16Medium, //TODO;
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

class _PinCodeKeyboardDeleteBtn extends StatelessWidget {
  const _PinCodeKeyboardDeleteBtn({Key? key, required this.onBackspace})
      : super(key: key);

  static const _buttonSize = 78.0;

  final VoidCallback? onBackspace;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: 4,
        child: SizedBox(
          width: _buttonSize,
          height: _buttonSize,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: onBackspace,
            child: SvgPicture.asset(
              ImgPathsSvg.iconDeleteKey,
            ),
          ),
        ),
      );
}
