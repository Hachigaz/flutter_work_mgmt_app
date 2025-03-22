import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_work_mgmt_app/commons/models/account.dart';

class AuthRepository {
  final _storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
  );
  AccountRecord? _currentAccount;
  StaffRecord? _currentStaffInfo;

  get currentAccount => _currentAccount;
  get currentStaffInfo => _currentStaffInfo;

  AuthRepository() : super();

  Future<bool> login({required String accountname, required String password}) {
    AccountRecord? accountRecord = AccountRecord(
      id: 0,
      staffId: 0,
      loginName: "abc123123",
      avatar: "avatar.jpg",
      password: null,
      isActive: true,
      dateCreated: DateTime.now(),
      lastLogin: DateTime.now(),
    );

    StaffRecord staffRecord = StaffRecord(
      fullName: "Nguyen van a",
      dob: DateTime.now(),
      gender: Gender.male,
      homeAddress: "ABC 123 123",
      phoneNumber: "123123",
      email: "a@gmail.com",
      dateEmployed: DateTime.now(),
    );

    Future<bool> result = Future<bool>.delayed(
      Duration(seconds: 2),
      () => true,
    );
    result = result.then((value) {
      _postLoginInit(accountRecord: accountRecord, staffRecord: staffRecord);
      return value;
    });
    //login logic

    return result;
  }

  Future<bool> pre_login() async {
    final loginTokenStr = await _storage.read(key: "login_tok");
    final loginTokExprStr = await _storage.read(key: "login_tok_expr");

    if (loginTokenStr != null) {
      //check login token if it is still valid
      final loginTokExpr = DateTime.parse(loginTokExprStr!);

      if (loginTokExpr.isAfter(DateTime.now().toUtc())) {
        await http.post(
          Uri.http(dotenv.env["API_URL"]!, "/api/login/token", {}),
          headers: {},
          body: {"login_token": loginTokenStr},
        );
      }
    }

    //check refresh token if it is still valid
    final refreshTokenStr = await _storage.read(key: "refresh_tok");
    final refreshTokExprStr = await _storage.read(key: "refresh_tok_expr");

    if (refreshTokenStr != null) {
      final refreshTokExpr = DateTime.parse(refreshTokExprStr!);

      if (refreshTokExpr.isAfter(DateTime.now().toUtc())) {
        await http.post(
          Uri.http(dotenv.env["API_URL"]!, "/api/login/refresh", {}),
          headers: {},
          body: {},
        );
      }
    }

    _postLoginInit(
      accountRecord: AccountRecord(
        id: 0,
        staffId: 0,
        loginName: "abc123123",
        avatar: "avatar.jpg",
        password: null,
        isActive: true,
        dateCreated: DateTime.now(),
        lastLogin: DateTime.now(),
      ),
      staffRecord: StaffRecord(
        fullName: "Nguyen van a",
        dob: DateTime.now(),
        gender: Gender.male,
        homeAddress: "ABC 123 123",
        phoneNumber: "123123",
        email: "a@gmail.com",
        dateEmployed: DateTime.now(),
      ),
    );

    return Future<bool>.delayed(Duration.zero, () => true);
  }

  void _postLoginInit({
    required AccountRecord accountRecord,
    required StaffRecord staffRecord,
  }) {
    _currentAccount = accountRecord;
    _currentStaffInfo = staffRecord;
  }

  void logout() {
    _currentAccount = null;
    _currentStaffInfo = null;
    _removeAuthTokens();
  }

  void _removeAuthTokens() {
    _storage.delete(key: "login_tok");
    _storage.delete(key: "login_tok_expr");
    _storage.delete(key: "refresh_tok");
    _storage.delete(key: "refresh_tok_expr");
  }
}
