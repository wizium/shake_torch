import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '/screens/screen_torch.dart';

colorPicker({
  required context,
}) async {
  ColorPicker(

    color: backgroundColor,
    pickerTypeTextStyle: const TextStyle().merge(
      const TextStyle(
        fontSize: 18,
      ),
    ),
    onColorChanged: (Color color) {
      colorController.add(color);
    },
    actionButtons: const ColorPickerActionButtons(
      dialogActionButtons: false,
    ),
  ).showPickerDialog(context);
}
