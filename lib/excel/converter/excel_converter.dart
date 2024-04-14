import 'package:storetools/excel/rowhelper/row_helper.dart';

///表格数据转换器
abstract class ExcelConverter<T, R> {
  T? covert(R row, RowHelper? helper);
}