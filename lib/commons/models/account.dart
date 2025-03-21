import 'package:flutter_work_mgmt_app/commons/models/model.dart';

class AccountRecord {
  final ID? id;
  final ID? staffId;
  final String? avatar;
  final String? loginName;
  final String? password;
  final bool? isActive;
  final DateTime? dateCreated;
  final DateTime? lastLogin;

  const AccountRecord({
    this.id,
    this.staffId,
    this.avatar,
    this.loginName,
    this.password,
    this.isActive,
    this.dateCreated,
    this.lastLogin,
  });
}

enum Gender {
  male(label: "Nam"),
  fename(label: "Nữ");

  final String label;

  const Gender({required this.label});
}

class StaffRecord {
  final String? fullName;
  final DateTime? dob;
  final Gender? gender;
  final String? homeAddress;
  final String? phoneNumber;
  final String? email;
  final DateTime? dateEmployed;

  const StaffRecord({
    this.fullName,
    this.dob,
    this.gender,
    this.homeAddress,
    this.phoneNumber,
    this.email,
    this.dateEmployed,
  });
}
