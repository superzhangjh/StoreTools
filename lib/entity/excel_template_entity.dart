///表格模版
class ExcelTemplateEntity {
  String name;
  List<ExcelTemplateCellEntity> cells;

  ExcelTemplateEntity({ required this.name, required this.cells });
}

///表格模板元素
class ExcelTemplateCellEntity {
  //表格中的名称
  String name;
  //对应entity类的属性名
  String field;
  ExcelCellType type;

  ExcelTemplateCellEntity({ required this.name, required this.type, required this.field });
}

///表格元素类型
enum ExcelCellType {
  text,
  number,
  date
}
