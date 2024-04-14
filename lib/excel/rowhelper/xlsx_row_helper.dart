import 'package:excel/excel.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';

import '../utils/cell_value_utils.dart';

class XlsxRowHelper extends RowHelper {
  final Map<String, int> _map = {};

  XlsxRowHelper({ required List<Data?> rowData }) {
    for (var value in rowData) {
      if (value != null && value.value is TextCellValue) {
        var name = CellValueUtils.getString(value.value);
        if (name?.isNotEmpty == true) {
          _map[name!] = value.columnIndex;
          print("设置下标 ${name} rowIndex:${value.columnIndex}");
        }
      }
    }
  }

  @override
  int? getIndex(String name) {
    return _map[name];
  }
}