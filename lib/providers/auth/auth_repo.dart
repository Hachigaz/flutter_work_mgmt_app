import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_work_mgmt_app/providers/base_loader/repos/storage_repo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_work_mgmt_app/data/models/accounts.dart';

part "models.dart";

const _userTokenStorageLabels = "user_tokens";

class AuthRepository {
  AccountRecord? _currentAccount;
  StaffRecord? _currentStaffInfo;

  AccountRecord? get currentAccount => _currentAccount;
  StaffRecord? get currentStaffInfo => _currentStaffInfo;

  final StorageRepository _storageRepo;

  AuthRepository(StorageRepository storageRepo)
    : _storageRepo = storageRepo,
      super();

  Future<bool> login({
    required String username,
    required String password,
  }) async {
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

    final result = await http.post(
      Uri.parse("${dotenv.env["API_URL"]}/api/auth/login"),
      headers: <String, String>{},
      body: {"username": username, "password": password},
    );

    if(result.statusCode==200){
      
    }else{

    }

    //login logic
    _postLoginInit(accountRecord: accountRecord, staffRecord: staffRecord);

    return true;
  }

  Future<bool> pre_login() async {
    final userTokenData = await _getUserTokens();
    bool isLoginSuccess = false;

    if (userTokenData == null) {
      return false;
    }

    final loginToken = userTokenData.access_token.token;
    final loginTokExpr = userTokenData.access_token.token_expr;

    if (loginTokExpr.isAfter(DateTime.now().toUtc())) {
      final result = await http.post(
        Uri.http(dotenv.env["API_URL"]!, "/api/login/token", {}),
        headers: {},
        body: {"access_token": loginToken},
      );

      if (result.statusCode == 200) {
        isLoginSuccess = true;
      }
    }

    //check refresh token if it is still valid
    final refreshToken = userTokenData.refresh_token.token;
    final refreshTokExpr = userTokenData.refresh_token.token_expr;

    if (refreshTokExpr.isAfter(DateTime.now().toUtc())) {
      final result = await http.post(
        Uri.http(dotenv.env["API_URL"]!, "/api/login/refresh", {}),
        headers: {},
        body: {"refresh_token": refreshToken},
      );

      if (result.statusCode == 200) {
        isLoginSuccess = true;
      }
    }

    if (isLoginSuccess) {
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
    }

    return Future<bool>.delayed(Duration.zero, () => isLoginSuccess);
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

  Future<void> _saveAuthTokens({
    TokenData? accessToken,
    TokenData? refreshToken,
    TokenData? userToken,
  }) async {
    final oldTokenData = await _getUserTokens() as UserTokenData;

    _storageRepo.secureStorage.write(
      key: _userTokenStorageLabels,
      value: jsonEncode(
        UserTokenData(
          access_token: accessToken ?? oldTokenData.access_token,
          refresh_token: refreshToken ?? oldTokenData.refresh_token,
          user_token: userToken ?? oldTokenData.user_token,
        ),
      ),
    );
  }

  Future<UserTokenData?> _getUserTokens() async {
    final userTokensStr = await _storageRepo.secureStorage.read(
      key: "user_tokens",
    );

    if (userTokensStr == null) {
      return null;
    }

    return UserTokenData.fromJson(jsonDecode(userTokensStr));
  }

  void _removeAuthTokens() {
    _storageRepo.secureStorage.delete(key: _userTokenStorageLabels);

    //send request to server to revoke tokens
  }
}
