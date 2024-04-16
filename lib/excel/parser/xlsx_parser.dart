import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:storetools/asyncTask/async_task.dart';
import 'package:storetools/asyncTask/data/isolate_data.dart';
import 'package:storetools/excel/converter/xlsx_converter.dart';
import 'package:storetools/excel/entity/parser_info.dart';
import 'package:storetools/excel/parser/excel_parser.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';
import 'package:storetools/excel/rowhelper/xlsx_row_helper.dart';

class XlsxParser extends ExcelParser<XlsxConverter> {
  //解析容量
  static const parseCapacity = 100;
  static const maxIsolateCount = 100;

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
      print("开始执行 tableName:$tableName");
      var startTime = DateTime.now();
      if (table != null) {
        //多任务解析数据，并添加到结果列表
        for (var entities in await Future.wait(_parallelParse<T>(table, tableIndex, converter))) {
          list ??= [];
          list.addAll(entities);
        }
      }
      var duration = DateTime.now().difference(startTime);
      print("结束执行 耗时:${duration.inMilliseconds}毫秒");
      tableIndex++;
    }

    return Future(() => list);
  }

  List<Future<List<T>>> _parallelParse<T>(Sheet sheet, int tableIndex, XlsxConverter converter) {
    var maxRows = sheet.maxRows;
    List<Future<List<T>>>? futures = [];
    if (maxRows > 1) {
      RowHelper rowHelper = XlsxRowHelper(rowData: sheet.rows[0]);
      var parallelCount = min(maxIsolateCount, (maxRows / parseCapacity).ceil());
      var capacity = (maxRows / parallelCount).ceil();
      for (var i=0; i<maxRows; i+=capacity) {
        //通过隔离异步执行
        var completer = Completer<List<T>>();
        var rows = sheet.rows.sublist(i, min(maxRows, i + capacity));
        print("分段执行 start:$i end:${i+capacity} maxRows:$maxRows");
        asyncTaskWithTriple<List<T>, XlsxConverter, RowHelper, List<List<Data?>>>(converter, rowHelper, rows, doInBackground<T>, onReceive: (data) {
          completer.complete(data);
        });
        //添加到future列表
        futures.add(completer.future.then((value) {
          //回调进度
          if (parserCallback != null) {
            parserCallback!(ParserProgress(tableIndex: tableIndex, rowIndex: i + rows.length, rowTotal: maxRows));
          }
          return value;
        }));
      }
    }
    return futures;
  }
}

void doInBackground<T>(TripleIsolateData<List<T>, XlsxConverter, RowHelper, List<List<Data?>>> isolateData) {
  List<T> data = [];
  for (var row in isolateData.param3) {
    var entity = isolateData.param1.covert(row, isolateData.param2);
    data.add(entity);
  }
  isolateData.emitter.emit(data);
}