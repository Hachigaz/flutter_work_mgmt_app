import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_work_mgmt_app/providers/base_loader/repos/storage_repo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_work_mgmt_app/data/models/accounts.dart';

class AuthRepository {
  AccountRecord? _currentAccount;
  StaffRecord? _currentStaffInfo;

  AccountRecord? get currentAccount => _currentAccount;
  StaffRecord? get currentStaffInfo => _currentStaffInfo;

  final StorageRepository _storageRepo;

  AuthRepository(StorageRepository storageRepo)
    : _storageRepo = storageRepo,
      super();

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
      fullName: "Nhân viên Á Châu",
      dob: DateTime.now(),
      gender: Gender.male,
      homeAddress: "273 An Dương Vương",
      phoneNumber: "0123123123",
      email: "achau@gmail.com",
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
    final loginTokenStr = await _storageRepo.secureStorage.read(
      key: "login_tok",
    );
    final loginTokExprStr = await _storageRepo.secureStorage.read(
      key: "login_tok_expr",
    );

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
    final refreshTokenStr = await _storageRepo.secureStorage.read(
      key: "refresh_tok",
    );
    final refreshTokExprStr = await _storageRepo.secureStorage.read(
      key: "refresh_tok_expr",
    );

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

  void logout() {
    _removeAuthTokens();
  }

  void _postLoginInit({
    required AccountRecord accountRecord,
    required StaffRecord staffRecord,
  }) {
    _currentAccount = accountRecord;
    _currentStaffInfo = staffRecord;
  }

  void _saveRefreshToken(String refresh_tok, DateTime refresh_tok_expr) {
    _storageRepo.secureStorage.write(key: "refresh_tok", value: refresh_tok);
    _storageRepo.secureStorage.write(
      key: "refresh_tok_expr",
      value: refresh_tok_expr.toString(),
    );
  }

  void _saveLoginToken(String login_tok, DateTime login_tok_expr) {
    _storageRepo.secureStorage.write(key: "login_tok", value: login_tok);
    _storageRepo.secureStorage.write(
      key: "login_tok_expr",
      value: login_tok_expr.toString(),
    );
  }

  void _removeAuthTokens() {
    _storageRepo.secureStorage.delete(key: "login_tok");
    _storageRepo.secureStorage.delete(key: "login_tok_expr");
    _storageRepo.secureStorage.delete(key: "refresh_tok");
    _storageRepo.secureStorage.delete(key: "refresh_tok_expr");

    //send request to server to revoke tokens
  }
}
