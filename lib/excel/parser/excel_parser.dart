import '../callback/parser_callback.dart';
import '../converter/excel_converter.dart';

///文件解析器
abstract class ExcelParser<C extends ExcelConverter> {
  List<String> fileExtensions;
  ParserCallback? parserCallback;

  ExcelParser({ required this.fileExtensions });

  ///解析文件
  Future<List<T>?> parse<T>(String filePath, C converter);
}