import 'package:excel/excel.dart';
import 'package:storetools/excel/rowhelper/row_helper.dart';

class XlsxRowHelper extends RowHelper<List<Data?>> {
  XlsxRowHelper({ required List<Data?> rowData }) : super(rowData: rowData) {
    print("a");
  }

  @override
  int getIndex(String name) {
    // TODO: implement getIndex
    throw UnimplementedError();
  }
}