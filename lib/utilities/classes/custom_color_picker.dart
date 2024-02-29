import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';

class CustomDatePicker {
  static Future<Color> showColor() async {
    final Color color =  await showColorPickerDialog(
      Get.context!,
      Color(AppColors.primary.value),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      showColorCode: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        copyButton: true,
        pasteButton: true,
        longPressMenu: true,
      ),
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 320),
    );
    return color;
  }
}
