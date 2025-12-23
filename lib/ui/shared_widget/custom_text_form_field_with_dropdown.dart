import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shantika_agen/ui/style.dart';
import '../color.dart';
import '../typography.dart';
import 'custom_dropdown_button.dart';
import 'custom_form_field.dart';

// ignore: must_be_immutable
class CustomTextFormFieldWithDropDown extends StatelessWidget {
  CustomTextFormFieldWithDropDown(
      {super.key,
      this.titleSection,
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
      this.selectedItem,
      required this.dropdownItems,
      this.onDropdownChanged});

  final String? titleSection;
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
  final OptionValue? selectedItem;
  final List<OptionValue> dropdownItems;
  final void Function(OptionValue?)? onDropdownChanged;

  @override
  Widget build(BuildContext context) {
    const inputStyle = TextStyle(
      color: black900,
      fontSize: 14,
    );
    if (defaultValue != null) {
      controller.text = defaultValue ?? "";
    }
    return CustomFormField(
      titleSection: titleSection ?? '',
      helper: helper,
      helperText: helperText,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderNeutral),
                  left: BorderSide(color: borderNeutral),
                  bottom: BorderSide(color: borderNeutral),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
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
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintStyle: const TextStyle(color: textNeutralSecondary, fontWeight: FontWeight.w400),
                  suffixIcon: suffixIcon,
                  prefixText: prefixText,
                  prefixStyle: const TextStyle(color: textNeutralSecondary),
                  prefix: prefix,
                  prefixIcon: prefixIcon,
                  prefixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
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
                  // if (focusNode?.hasFocus ?? false) {
                  //   onSubmit?.call(controller.text);
                  // }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: black50,
                border: Border(
                  left: BorderSide(color: borderNeutral, width: 2),
                  top: BorderSide(color: borderNeutral),
                  right: BorderSide(color: borderNeutral),
                  bottom: BorderSide(color: borderNeutral),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: DropdownButtonFormField2<OptionValue>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 4),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: selectedItem,
                hint: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: sRegular.copyWith(color: textNeutralSecondary),
                  ),
                ),
                items: [
                  ...dropdownItems.map(
                    (item) => DropdownMenuItem<OptionValue>(
                      value: item,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.label,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: sRegular.copyWith(color: textNeutralPrimary),
                        ),
                      ),
                    ),
                  ),
                ],
                selectedItemBuilder: (ctx) =>
                    dropdownItems.map((item) => selectedItemBuilderWidget(item.label)).toList(),
                onChanged: onDropdownChanged,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: IconStyleData(
                  openMenuIcon: SvgPicture.asset(
                    'assets/images/ic_caret_up.svg',
                    color: textNeutralPrimary,
                  ),
                  icon: SvgPicture.asset(
                    'assets/images/ic_caret_down.svg',
                    color: textNeutralPrimary,
                  ),
                  iconSize: 12,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  maxHeight: 200,
                  offset: const Offset(0, -8),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(2),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  selectedMenuItemBuilder: (ctx, child) => selectedMenuItemBuilderWidget(child),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget selectedMenuItemBuilderWidget(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: black50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Container selectedItemBuilderWidget(String item) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        overflow: TextOverflow.ellipsis,
        selectedItem?.label ?? '',
        style: sRegular,
        maxLines: 1,
      ),
    );
  }
}
