import 'package:excel/excel.dart';
import 'package:storetools/excel/converter/excel_converter.dart';

///xlsx\xls转化器
abstract class XlsxConverter<T> extends ExcelConverter<T, List<Data?>> {}