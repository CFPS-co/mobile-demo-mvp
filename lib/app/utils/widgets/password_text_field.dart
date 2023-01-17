import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/typdefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    required this.isPasswordVisible,
    required this.textFormFieldValidator,
    required this.label,
    this.onChanged,
    this.textEditingController,
    super.key,
  });

  final ValueNotifier<bool> isPasswordVisible;
  final String label;
  final Function(String value)? onChanged;
  final TextFormFieldValidator textFormFieldValidator;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: !isPasswordVisible.value,
      onChanged: onChanged,
      validator: textFormFieldValidator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: isPasswordVisible.value ? const Icon(Icons.remove_red_eye) : SvgPicture.asset(ImgPathsSvg.iconEye),
          onPressed: () {
            isPasswordVisible.value = !isPasswordVisible.value;
          },
        ),
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.holly40),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.silverSand),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueDianne, width: 2),
        ),
      ),
    );
  }
}
