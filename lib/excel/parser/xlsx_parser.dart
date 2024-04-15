import 'dart:async';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:storetools/excel/converter/xlsx_converter.dart';
import 'package:storetools/excel/entity/parser_info.dart';
import 'package:storetools/excel/parser/excel_parser.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';
import 'package:storetools/excel/rowhelper/xlsx_row_helper.dart';

class XlsxParser extends ExcelParser<XlsxConverter> {
  XlsxParser(): super(fileExtensions: ['.xlsx', '.xls']);

  ///todo：修改成多个线程同时执行解析工作
  @override
  Future<List<T>?> parse<T>(String filePath, XlsxConverter converter) async {
    var bytes = await File(filePath).readAsBytes();
    var excel = Excel.decodeBytes(bytes);
    List<T>? list;
    int tableIndex = 0;
    for (var tableName in excel.tables.keys) {
      var table = excel.tables[tableName];
      if (table != null) {
        RowHelper? rowHelper;
        for (var i=0; i<table.rows.length; i++) {
          //回调解析进度
          if (parserCallback != null) {
            parserCallback!(ParserProgress(tableIndex: tableIndex, rowIndex: i, rowTotal: table.maxRows));
          }

          var row = table.rows[i];
          if (i == 0) {
            //生成标题解析器
            rowHelper = XlsxRowHelper(rowData: row);
          } else if (rowHelper != null) {
            list ??= [];
            list.add(converter.covert(row, rowHelper));
          }
        }
      }
      tableIndex++;
    }

    return Future(() => list);
  }
}