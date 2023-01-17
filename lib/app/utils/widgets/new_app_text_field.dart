import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/typdefs.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NewAppTextField extends HookWidget {
  const NewAppTextField({
    super.key,
    this.hintText,
    this.enabled = true,
    this.label,
    this.textInputAction,
    this.textInputType,
    this.textEditingController,
    this.onSubmitted,
    this.validators = const <FormFieldValidator>[],
    this.fillColor,
    this.onTap,
    this.maxLines = 1,
    this.initialValue,
    this.onChanged,
    this.enableInteractiveSelection = true,
    this.minLines,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus,
    this.obscureText,
    this.focusNode,
    this.contentPadding,
    this.expands,
    this.maxLength,
    this.errorText,
    this.textFormFieldValidator,
  });

  final String? hintText;
  final bool enabled;
  final String? label;
  final String? errorText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final Function(String)? onSubmitted;
  final List<String? Function(String? value)> validators;
  final int? maxLines;
  final Color? fillColor;
  final VoidCallback? onTap;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool enableInteractiveSelection;
  final int? minLines;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final bool? obscureText;
  final FocusNode? focusNode;
  final EdgeInsets? contentPadding;
  final bool? expands;
  final int? maxLength;
  final TextFormFieldValidator? textFormFieldValidator;

  @override
  Widget build(BuildContext context) {
    final isFilled = useState(textEditingController?.text.isNotEmpty ?? false);
    final hasFocus = useState(false);
    final node = useFocusNode();
    useEffect(() {
      node.addListener(() async {
        hasFocus.value = node.hasFocus;
      });
      return () => node.removeListener(() {});
    }, [node]);

    return Stack(
      children: [
        TextFormField(
          focusNode: focusNode ?? node,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          obscureText: obscureText ?? false,
          autofocus: autofocus ?? false,
          readOnly: readOnly ?? false,
          enabled: enabled,
          initialValue: initialValue,
          autocorrect: false,
          textInputAction: textInputAction,
          enableInteractiveSelection: enableInteractiveSelection,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands ?? false,
          keyboardType: textInputType,
          controller: textEditingController,
          validator: textFormFieldValidator,
          onFieldSubmitted: (value) {
            isFilled.value = value.isNotEmpty;
            onSubmitted?.call(value);
          },
          onTap: onTap,
          onChanged: (value) {
            isFilled.value = value.isNotEmpty;
            if (onChanged != null) onChanged!(value);
          },
          textAlignVertical: TextAlignVertical.bottom,
          style: getIt<ThemeManager>().textStyles.bodyText1Regular,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.silverSand, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blueDianne, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            counterText: '',
            contentPadding: contentPadding ??
                const EdgeInsets.only(
                  left: 16,
                  top: 28,
                  bottom: 12,
                ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: label != null
                ? Text(
                    label!,
                    style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                          color: AppColors.holly40,
                          fontWeight: FontWeight.w600,
                        ),
                  )
                : null,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorMaxLines: 2,
            errorStyle: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                  color: AppColors.bitterSweet,
                  fontWeight: FontWeight.w600,
                ),
            fillColor: enabled
                ? isFilled.value && !hasFocus.value
                    ? AppColors.concrete.withOpacity(.15)
                    : AppColors.transparent
                : AppColors.concrete,
            filled: true,
            hintText: hintText,
            hintStyle: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                  color: AppColors.holly40,
                  fontWeight: FontWeight.w600,
                ),
            errorText: errorText,
          ),
        ),
        if (label != null && isFilled.value || (label != null && hasFocus.value && !isFilled.value))
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12),
            child: Text(
              label!,
              style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                    color: AppColors.holly40,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
      ],
    );
  }
}
