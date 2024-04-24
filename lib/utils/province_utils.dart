import 'package:storetools/const/provinces.dart';

class ProvinceUtils {
  static ProvinceUtils? _instance;
  final _provinceMap = <String, String>{};

  ProvinceUtils._() {
    _initProvince();
  }

  factory ProvinceUtils.getInstance() {
    _instance ??= ProvinceUtils._();
    return _instance!;
  }

  _initProvince() {
    for (var element in Province.values) {
      _provinceMap[element.name] = element.cnName;
    }
  }

  ///通过省份的code获取名称
  String? getNameByCode(String? code) {
    return _provinceMap[code];
  }
}