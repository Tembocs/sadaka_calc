import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericTextFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      double num = double.parse(newValue.text.replaceAll(',', ''));
      final f = NumberFormat("#,###");
      final newString = f.format(num);
      return TextEditingValue(
          selection: newValue.text.length > oldValue.text.length
              ? TextSelection.fromPosition(
              TextPosition(offset: newString.length))
              : newValue.selection,
          text: newString);
    } else {
      return newValue;
    }
  }
}

class ThousandSeparatorTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue) {
    // So that we have thousand comma separator
    print("Before: ${newValue.text}");
    String createdText = newValue.text;
    createdText = createdText.replaceAll(RegExp(r','), '');
    print("After: -> $createdText");

    return TextEditingValue(
      selection: TextSelection.fromPosition(TextPosition(offset: createdText.length)),
      text: _addThousandsSeparator(createdText));
  }

  String _addThousandsSeparator(String value) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    return value.replaceAllMapped(reg, mathFunc);
  }
}