import 'package:fluttertoast/fluttertoast.dart';

///显示吐司
void showToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 16
  );
}