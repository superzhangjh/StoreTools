import 'dart:async';

import 'package:storetools/excel/converter/excel_converter.dart';
import 'package:storetools/excel/parser/excel_parser.dart';
import 'package:storetools/excel/parser/xlsx_parser.dart';

class ExcelKit {
  static ExcelKit? _instance;
  final List<ExcelParser> _excelParsers = [
    XlsxParser()
  ];

  ExcelKit._();

  // 工厂构造函数，用于返回单例实例
  factory ExcelKit.getInstance() {
    // 如果实例尚未创建，则创建一个新实例；否则返回现有实例
    _instance ??= ExcelKit._();
    return _instance!;
  }
  
  Future<List<T>?> encode<T>(String? filePath, ExcelConverter<T, dynamic> converter) async {
    for (var parser in _excelParsers) {
      for (var ext in parser.fileExtensions) {
        if (filePath?.endsWith(ext) == true) {
          return await Future.sync(() => parser.parse(filePath!, converter));
        }
      }
    }
    return null;
  }
}