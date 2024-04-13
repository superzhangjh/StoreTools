import 'dart:io';

import 'package:excel/excel.dart';
import 'package:storetools/excel/converter/xlsx_converter.dart';
import 'package:storetools/excel/parser/excel_parser.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';
import 'package:storetools/excel/rowhelper/xlsx_row_helper.dart';

class XlsxParser extends ExcelParser<XlsxConverter> {


  XlsxParser(): super(fileExtensions: ['.xlsx', '.xls']);

  @override
  Future<List<T>?> parse<T>(String filePath, XlsxConverter converter) {
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<T>? list;
    for (var tableName in excel.tables.keys) {
      var table = excel.tables[tableName];
      if (table != null) {
        RowHelper? rowHelper;
        for (var i=0; i<table.rows.length; i++) {
          var row = table.rows[i];
          if (i == 0) {
            rowHelper = XlsxRowHelper(rowData: row);
          } else if (rowHelper != null) {
            list ??= [];
            list.add(converter.covert(row, rowHelper));
          }
        }
      }
    }
    return Future(() => list);
  }
}