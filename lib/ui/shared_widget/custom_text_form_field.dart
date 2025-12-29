import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shantika_agen/ui/shared_widget/custom_form_field.dart';
import '../color.dart';
import '../dimension.dart';
import '../style.dart';
import '../typography.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.titleSection,
    this.isRequired = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.placeholder,
    this.errorText,
    this.prefixText,
    this.focusNode,
    this.obsecureText,
    this.validator,
    this.helper,
    this.helperText,
    this.onChanged,
    this.onSubmit,
    this.suffixIcon,
    this.maxLines,
    this.minLines,
    this.defaultValue,
    this.enabled,
    this.hintColor,
    this.onTap,
    this.inputFormatters,
    this.prefix,
    this.textValidator,
    this.prefixIcon,
    this.textInputAction,
    this.readOnly,
    this.suffixIconConstraints,
    this.subtitleSection,
    this.verticalContentPadding,
    this.width,
    this.titleStyle,
    this.placeholderStyle,
  });

  final String? titleSection;
  final bool isRequired;
  final String? subtitleSection;
  final BoxConstraints? suffixIconConstraints;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? defaultValue;
  final String? placeholder;
  final String? errorText;
  final String? prefixText;
  final Widget? helper;
  final String? helperText;
  final FocusNode? focusNode;
  final bool? obsecureText;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final String? Function(String)? validator;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final void Function()? onTap;
  Color? hintColor = Colors.grey.shade600;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final String? textValidator;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final double? verticalContentPadding;
  final double? width;

  // New parameters for customization
  final TextStyle? titleStyle;
  final TextStyle? placeholderStyle;

  @override
  Widget build(BuildContext context) {
    final inputStyle = smMedium.copyWith(color: black700_70);
    if (defaultValue != null) {
      controller.text = defaultValue ?? "";
    }

    return SizedBox(
      width: width,
      child: CustomFormField(
        titleSectionWidget: titleSection != null
            ? RichText(
          text: TextSpan(
            text: titleSection,
            style: titleStyle ?? smMedium.copyWith(color: black700_70),
            children: isRequired
                ? [
              TextSpan(
                text: ' *',
                style: titleStyle ?? smMedium.copyWith(color: textPrimary),
              )
            ]
                : [],
          ),
        )
            : null,
        helper: helper,
        helperText: helperText,
        child: TextFormField(
          readOnly: readOnly ?? false,
          onTap: onTap,
          textInputAction: textInputAction ?? TextInputAction.next,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: obsecureText ?? false,
          style: inputStyle,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          onFieldSubmitted: onSubmit,
          inputFormatters: inputFormatters,
          decoration: inputDecoration().copyWith(
            contentPadding: EdgeInsets.symmetric(
                horizontal: space400, vertical: verticalContentPadding ?? 0),
            hintStyle: placeholderStyle ??
                const TextStyle(
                    color: textNeutralSecondary, fontWeight: FontWeight.w400),
            suffixIcon: suffixIcon,
            prefixText: prefixText,
            prefixStyle: const TextStyle(color: textButtonOutlined),
            prefix: prefix,
            prefixIcon: prefixIcon,
            prefixIconConstraints:
            const BoxConstraints(minHeight: 20, minWidth: 20),
            hintText: placeholder,
            suffixIconConstraints: suffixIconConstraints,
            errorText: validator == null ? null : errorText,
            enabled: true,
          ),
          validator: (input) {
            if (validator != null) {
              return validator!(input!);
            }
            return null;
          },
          onChanged: onChanged,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
    );
  }
}