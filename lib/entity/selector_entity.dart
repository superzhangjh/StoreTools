///可选择的entity类
class SelectorEntity<T> {
  bool isSelected;
  T data;

  SelectorEntity({ required this.isSelected, required this.data });

  Map<String, dynamic> toJson() => {
    'isSelected': isSelected,
    'data': data
  };
}