class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.details,
  });

  final int? status;
  final String? message;
  final Details? details;

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      status: json["status"],
      message: json["message"],
      details: json["details"] == null ? null : Details.fromJson(json["details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "details": details?.toJson(),
  };

}

class Details {
  Details({
    required this.id,
    required this.companyId,
    required this.branchId,
    required this.empId,
    required this.roleId,
    required this.fullname,
    required this.gender,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.phone,
    required this.isPinEnable,
    required this.isAttendanceAllowed,
    required this.canUpdateFace,
    required this.ipRestricted,
    required this.expiryDate,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.fingerPrint,
    required this.designation,
    required this.empPin,
    required this.token,
    required this.branchName,
  });

  final int? id;
  final String? companyId;
  final String? branchId;
  final String? empId;
  final int? roleId;
  final String? fullname;
  final String? gender;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? image;
  final dynamic phone;
  final String? isPinEnable;
  final String? isAttendanceAllowed;
  final String? canUpdateFace;
  final String? ipRestricted;
  final DateTime? expiryDate;
  final String? isActive;
  final String? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fingerPrint;
  final String? designation;
  final String? empPin;
  final String? token;
  final List<String> branchName;

  factory Details.fromJson(Map<String, dynamic> json){
    return Details(
      id: json["id"],
      companyId: json["company_id"],
      branchId: json["branch_id"],
      empId: json["emp_id"],
      roleId: json["role_id"],
      fullname: json["fullname"],
      gender: json["gender"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      image: json["image"],
      phone: json["phone"],
      isPinEnable: json["is_pin_enable"],
      isAttendanceAllowed: json["is_attendance_allowed"],
      canUpdateFace: json["can_update_face"],
      ipRestricted: json["ip_restricted"],
      expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
      isActive: json["is_active"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      fingerPrint: json["fingerPrint"],
      designation: json["designation"],
      empPin: json["emp_pin"],
      token: json["token"],
      branchName: json["branch_name"] == null ? [] : List<String>.from(json["branch_name"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "branch_id": branchId,
    "emp_id": empId,
    "role_id": roleId,
    "fullname": fullname,
    "gender": gender,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "image": image,
    "phone": phone,
    "is_pin_enable": isPinEnable,
    "is_attendance_allowed": isAttendanceAllowed,
    "can_update_face": canUpdateFace,
    "ip_restricted": ipRestricted,
    "expiry_date": expiryDate,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "fingerPrint": fingerPrint,
    "designation": designation,
    "emp_pin": empPin,
    "token": token,
    "branch_name": branchName.map((x) => x).toList(),
  };

}
