import 'dart:async';

import 'package:storetools/asyncTask/async_owner.dart';
import 'package:storetools/asyncTask/async_task.dart';
import 'package:storetools/excel/callback/parser_callback.dart';
import 'package:storetools/excel/converter/excel_converter.dart';
import 'package:storetools/excel/entity/parser_info.dart';
import 'package:storetools/excel/parser/excel_parser.dart';
import 'package:storetools/excel/parser/xlsx_parser.dart';

import '../asyncTask/data/isolate_data.dart';

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

  ///解析表格
  ///[filePath]文件路径
  ///[converter]格式转换器
  ///[onResult]转换结果
  ///[onProgress]转换进度
  Future<AsyncOwner?> encode<T>(
      String? filePath,
      ExcelConverter<T, dynamic> converter,
      Function(List<T>?) onResult, {
        ParserCallback? onProgress
      }) {
    for (var parser in _excelParsers) {
      for (var ext in parser.fileExtensions) {
        if (filePath?.endsWith(ext) == true) {
          return asyncTaskWithTriple<ParserInfo<T>, ExcelParser, String, ExcelConverter>(parser, filePath!, converter, executeIo, onReceive: (data) {
            switch (data?.status) {
              case ParserInfo.statusComplete:
                onResult(data!.data);
                break;
                case ParserInfo.statusProgress:
                  if (onProgress != null) onProgress(data!.progress);
                  break;
            }
          });
        }
      }
    }
    return Future(() => null);
  }
}

void executeIo<T>(TripleIsolateData<ParserInfo<T>, ExcelParser, String, ExcelConverter> isolateData) async {
  isolateData.param1.parserCallback = (progress) {
    isolateData.emitter.emit(ParserInfo<T>.progress(progress));
  };
  var data = await isolateData.param1.parse<T>(isolateData.param2, isolateData.param3);
  isolateData.emitter.emit(ParserInfo<T>.complete(data));
}
