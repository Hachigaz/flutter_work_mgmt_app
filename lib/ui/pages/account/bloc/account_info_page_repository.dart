import 'package:flutter_work_mgmt_app/data/models/account.dart';

class AccountInfoPageRepository {
  final AccountRecord _accountRecord;
  final StaffRecord _staffRecord;

  AccountRecord get accountRecord => _accountRecord;
  StaffRecord get staffRecord => _staffRecord;

  AccountInfoPageRepository({
    required AccountRecord accountRecord,
    required StaffRecord staffRecord,
  }) : _accountRecord = accountRecord,
       _staffRecord = staffRecord;
}
