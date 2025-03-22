import 'dart:math';

String generateRandomString(int count) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  final random = Random();
  final str = String.fromCharCodes(
    List.generate(
      count,
      (index) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );
  return str;
}

int random100() {
  return Random().nextInt(201) - 100; // 1 to 100
}
