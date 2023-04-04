class URequestModel {
  URequestModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  final bool? success;
  final String? msg;
  final List<Dara> data;

  factory URequestModel.fromJson(Map<String, dynamic> json) {
    return URequestModel(
      success: json["success"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<Dara>.from(json["data"]!.map((x) => Dara.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Dara {
  Dara({
    required this.disbursed,
    required this.id,
    required this.title,
    required this.amount,
    required this.description,
    required this.department,
    required this.category,
    required this.media,
    required this.status,
    required this.userId,
    required this.userAccount,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.approver,
    required this.approverId,
  });

  final String? disbursed;
  final String? id;
  final String? title;
  final num? amount;
  final String? description;
  final Department? department;
  final Category? category;
  final String? media;
  final String? status;
  final ErId? userId;
  final UserAccount? userAccount;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? approver;
  final ErId? approverId;

  factory Dara.fromJson(Map<String, dynamic> json) {
    return Dara(
      disbursed: json["disbursed"],
      id: json["_id"],
      title: json["title"],
      amount: json["amount"],
      description: json["description"],
      department:
          json["department"] == null ? null : Department.fromJson(json["department"]),
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      media: json["media"],
      status: json["status"],
      userId: json["userId"] == null ? null : ErId.fromJson(json["userId"]),
      userAccount:
          json["userAccount"] == null ? null : UserAccount.fromJson(json["userAccount"]),
      companyId: json["companyId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      approver: json["approver"],
      approverId: json["approverId"] == null ? null : ErId.fromJson(json["approverId"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "disbursed": disbursed,
        "_id": id,
        "title": title,
        "amount": amount,
        "description": description,
        "department": department?.toJson(),
        "category": category?.toJson(),
        "media": media,
        "status": status,
        "userId": userId?.toJson(),
        "userAccount": userAccount?.toJson(),
        "companyId": companyId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "approver": approver,
        "approverId": approverId?.toJson(),
      };
}

class ErId {
  ErId({
    required this.id,
    required this.fullName,
  });

  final String? id;
  final String? fullName;

  factory ErId.fromJson(Map<String, dynamic> json) {
    return ErId(
      id: json["_id"],
      fullName: json["fullName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Department {
  Department({
    required this.id,
    required this.department,
  });

  final String? id;
  final String? department;

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json["_id"],
      department: json["department"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "department": department,
      };
}

class UserAccount {
  UserAccount({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.service,
  });

  final String? id;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final String? service;

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      id: json["_id"],
      accountName: json["accountName"],
      accountNumber: json["accountNumber"],
      bankName: json["bankName"],
      service: json["service"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "service": service,
      };
}
