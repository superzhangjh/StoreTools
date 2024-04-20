import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/utils/toast_utils.dart';

var allowedExtensions = ["xlsx", "xls", "csv", "tsv"];

///选择excel文件
Future<String?> pickExcel() async {
  var completer = Completer<String?>();
  var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions
  );
  var filePath = result?.files.single.path;
  if (filePath != null) {
    var found = allowedExtensions.find((e) => filePath!.endsWith(".$e")) != null;
    if (!found) {
      showLongToast('不支持的文件格式: $filePath');
      filePath = null;
    }
  }
  completer.complete(filePath);
  return await completer.future;
}
