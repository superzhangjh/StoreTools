import 'dart:ffi';

import 'package:excel/excel.dart';

class CellValueUtils {
  CellValueUtils._();

  static String? getString(CellValue? cellValue) {
    if (cellValue is TextCellValue) {
      return cellValue.value;
    }
    return cellValue?.toString();
  }

  static double getDouble(CellValue? cellValue) {
    if (cellValue is DoubleCellValue) {
      return cellValue.value;
    }
    if (cellValue is IntCellValue) {
      return cellValue.value.toDouble();
    }
    try {
      return double.parse(cellValue.toString());
    } catch (e) {
      print(e);
    }
    return 0;
  }
}