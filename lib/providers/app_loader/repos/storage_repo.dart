import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  late final SharedPreferences localPrefs;
  final secureStorage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
  );

  StorageRepository();

  Future<void> repoInit() async {
    localPrefs = await SharedPreferences.getInstance();
  }
}
