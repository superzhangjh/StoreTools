import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:storetools/excel/callback/parser_callback.dart';
import 'package:storetools/excel/converter/excel_converter.dart';
import 'package:storetools/excel/entity/parser_info.dart';
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

  ///解析表格
  ///[filePath]文件路径
  ///[converter]格式转换器
  ///[onResult]转换结果
  ///[onProgress]转换进度
  Future<Isolate>? encode<T>(
      String? filePath,
      ExcelConverter<T, dynamic> converter,
      Function(List<T>?) onResult, {
        ParserCallback? onProgress
      }) {
    for (var parser in _excelParsers) {
      for (var ext in parser.fileExtensions) {
        if (filePath?.endsWith(ext) == true) {
          return encodeIo(parser, filePath, converter, (info) {
            switch (info.status) {
              case ParserInfo.statusComplete:
                // onResult(info.data as? List<T>?);
                break;
              case ParserInfo.statusProgress:
                if (onProgress != null) onProgress(info.progress);
                break;
            }
          });
        }
      }
    }
    return null;
  }
}

Future<Isolate> encodeIo<T>(ExcelParser parser, String? filePath, ExcelConverter<T, dynamic> converter, Function(ParserInfo) onInfo) async {
  var receivePort = ReceivePort();
  var isolate = await Isolate.spawn(
      newThread,
      ThreadOwner<T>(
          uiSendPort: receivePort.sendPort,
          parser: parser,
          filePath: filePath,
          converter: converter
      )
  );
  receivePort.listen((message) {
    ///这里接收来自子线程的消息，回调出去
    print("接收子线程消息:${jsonEncode(message)}");
    onInfo(message);
  });
  return isolate;
}

///必须为顶层函数，否则会报错
void newThread<T>(ThreadOwner owner) {
  owner.parser.parserCallback = (progress) {
    print("进度发生改变${jsonEncode(progress)}");
    owner.uiSendPort.send(ParserInfo.progress(progress));
  };
  owner.parser.parse<T>(owner.filePath!, owner.converter).then((value) {
    owner.uiSendPort.send(ParserInfo.complete(value));
  });
}

class ThreadOwner<T> {
  SendPort uiSendPort;
  ExcelParser parser;
  String? filePath;
  ExcelConverter<T, dynamic> converter;

  ThreadOwner({
    required this.uiSendPort,
    required this.parser,
    required this.filePath,
    required this.converter
  });
}