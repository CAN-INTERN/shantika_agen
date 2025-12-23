// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:shantika_agen/ui/dimension.dart';
import 'package:shantika_agen/ui/shared_widget/custom_form_field.dart';
import '../color.dart';
import '../typography.dart';

// ignore: must_be_immutable
class CustomDropDownButton<T> extends StatelessWidget {
  CustomDropDownButton({
    super.key,
    required this.selectedItem,
    required this.dropdownItems,
    this.validator,
    this.onChanged,
    required this.hint,
    this.titleSection,
    this.selectedItemfontWeight,
    this.openMenuIcon,
    this.closeMenuIcon,
    this.borderSide,
    this.selectedItemColor,
    this.extras,
    this.isIcon = false,
    required this.getLabel, // Function buat ambil label dari model yang dipakai
  });

  final T? selectedItem;
  final List<T> dropdownItems;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String hint;
  final String? titleSection;
  final FontWeight? selectedItemfontWeight;
  final Widget? openMenuIcon;
  final Widget? closeMenuIcon;
  final BorderSide? borderSide;
  final Color? selectedItemColor;
  final Widget? extras;
  final bool isIcon;
  final String Function(T) getLabel; // Ambil label dari model

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      titleSection: titleSection ?? '',
      child: DropdownButtonFormField2<T>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: 4),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: borderNeutral),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderNeutral),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        value: selectedItem,
        hint: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: sRegular.copyWith(color: textNeutralPrimary),
          ),
        ),
        items: dropdownItems
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      isIcon
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(borderRadius500),
                              child: SvgPicture.asset('assets/images/ic_atlas_brooks.svg'),
                            )
                          : SizedBox.shrink(),
                      const SizedBox(width: space150),
                      Flexible(
                        child: Text(
                          getLabel(item), // Ambil label dari function getLabel
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: sRegular.copyWith(color: textNeutralPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        validator: validator,
        selectedItemBuilder: (ctx) => dropdownItems
            .map(
              (item) => selectedItemBuilderWidget(getLabel(item)),
            )
            .toList(),
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: IconStyleData(
          openMenuIcon: openMenuIcon ??
              SvgPicture.asset(
                'assets/images/ic_caret_down.svg',
                color: textNeutralPrimary,
              ),
          icon: closeMenuIcon ??
              SvgPicture.asset(
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
        item,
        style: sRegular,
        maxLines: 1,
      ),
    );
  }
}

class OptionValue extends Equatable {
  const OptionValue({
    required this.value,
    required this.label,
    this.latLng,
  });

  final String value;
  final String label;
  final LatLng? latLng;

  @override
  List<Object?> get props => [value, label, latLng];
}
