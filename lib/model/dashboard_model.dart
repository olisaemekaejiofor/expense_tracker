class DashboardModel {
  DashboardModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  final bool? success;
  final String? msg;
  final List<Dash> data;

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      success: json["success"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<Dash>.from(json["data"]!.map((x) => Dash.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Dash {
  Dash({
    required this.id,
    required this.department,
    required this.spendingLimit,
    required this.amountSpent,
  });

  final String? id;
  final String? department;
  final num? spendingLimit;
  final num? amountSpent;

  factory Dash.fromJson(Map<String, dynamic> json) {
    return Dash(
      id: json["_id"],
      department: json["department"],
      spendingLimit: json["spendingLimit"],
      amountSpent: json["amountSpent"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "department": department,
        "spendingLimit": spendingLimit,
        "amountSpent": amountSpent,
      };
}
