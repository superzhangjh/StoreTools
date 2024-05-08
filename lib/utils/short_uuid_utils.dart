import 'dart:math';

class ShortUUidUtils {
  static String generateShortId() {
    final random = Random();
    final randomNumber = random.nextInt(1000000);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$timestamp$randomNumber';
  }
}