import 'package:flutter_work_mgmt_app/data/models/model.dart';

class AccountRecord extends DataRecord {
  final ID? staffId;
  final String? avatar;
  final String? loginName;
  final String? password;
  final bool? isActive;
  final DateTime? dateCreated;
  final DateTime? lastLogin;

  const AccountRecord({
    super.id,
    this.staffId,
    this.avatar,
    this.loginName,
    this.password,
    this.isActive,
    this.dateCreated,
    this.lastLogin,
  });

  @override
  Map<String, dynamic> toJson() => {
    "staffId": staffId,
    "avatar": avatar,
    "loginName": loginName,
    "password": password,
    "isActive": isActive,
    "dateCreated": dateCreated,
    "lastLogin": lastLogin,
  };

  factory AccountRecord.fromJson(Map<String, dynamic> json) => AccountRecord(
    staffId: json["staffId"],
    avatar: json["avatar"],
    loginName: json["loginName"],
    password: json["password"],
    isActive: json["isActive"],
    dateCreated: json["dateCreated"],
    lastLogin: json["lastLogin"],
  );
}

enum Gender {
  male(label: "Nam"),
  fename(label: "Nữ");

  final String label;

  const Gender({required this.label});

  Map<String, dynamic> toJson() => {"name": name};

  static Gender fromName({required String name}) {
    return Gender.values.firstWhere((value) => value.name == name);
  }
}

class StaffRecord extends DataRecord {
  final String? fullName;
  final DateTime? dob;
  final Gender? gender;
  final String? homeAddress;
  final String? phoneNumber;
  final String? email;
  final DateTime? dateEmployed;

  const StaffRecord({
    super.id,
    this.fullName,
    this.dob,
    this.gender,
    this.homeAddress,
    this.phoneNumber,
    this.email,
    this.dateEmployed,
  });

  @override
  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "dob": dob,
    "gender": gender,
    "homeAddress": homeAddress,
    "phoneNumber": phoneNumber,
    "email": email,
    "dateEmployed": dateEmployed,
  };

  factory StaffRecord.fromJson(Map<String, dynamic> json) => StaffRecord(
    id: json["id"],
    fullName: json["fullName"],
    dob: json["dob"],
    gender: Gender.fromName(name: json["gender"]),
    homeAddress: json["homeAddress"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    dateEmployed: json["dateEmployed"],
  );
}
