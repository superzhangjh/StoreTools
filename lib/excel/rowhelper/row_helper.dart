///行帮助类
abstract class RowHelper<R> {
  R rowData;

  RowHelper({ required this.rowData })

  ///获取Cell的下表
  int getIndex(String name);
}