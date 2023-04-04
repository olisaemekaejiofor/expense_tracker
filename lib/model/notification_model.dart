class NotificationModel {
  NotificationModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  final bool? success;
  final String? msg;
  final List<Datum> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json["success"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.status,
    required this.departmentId,
    required this.recipient,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final UserId? userId;
  final String? title;
  final String? message;
  final String? status;
  final String? departmentId;
  final String? recipient;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      title: json["title"],
      message: json["message"],
      status: json["status"],
      departmentId: json["departmentId"],
      recipient: json["recipient"],
      companyId: json["companyId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "title": title,
        "message": message,
        "status": status,
        "departmentId": departmentId,
        "recipient": recipient,
        "companyId": companyId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class UserId {
  UserId({
    required this.id,
  });

  final String? id;

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}
