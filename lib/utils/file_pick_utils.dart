import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:storetools/utils/toast_utils.dart';

///选择excel文件
Future<String?> pickExcel() async {
  var completer = Completer<String?>();
  var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx']
  );
  var filePath = result?.files.single.path;
  if (filePath != null) {
    if (!filePath.endsWith(".xlsx") && !filePath.endsWith(".xls") && !!filePath.endsWith(".csv") && !filePath.endsWith(".tsv")) {
      showToast('仅支持xlsx/xls/csv/tsv格式的文件');
    }
  }
  // else {
  //   showToast('选择文件错误，请重试');
  // }
  completer.complete(filePath);
  return await completer.future;
}
