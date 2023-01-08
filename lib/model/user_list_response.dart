class UserListResponse {
  int? statusCode;
  Data? data;

  UserListResponse({this.statusCode, this.data});

  UserListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<Rows>? rows;

  Data({this.count, this.rows});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int? id;
  String? firstName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? profilePicture;
  String? userName;
  String? bio;
  bool? contactSync;
  int? profileLevel;
  bool? notificationEnrolled;
  bool? status;
  String? createdAt;
  List<Devices>? devices;

  Rows(
      {this.id,
        this.firstName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.profilePicture,
        this.userName,
        this.bio,
        this.contactSync,
        this.profileLevel,
        this.notificationEnrolled,
        this.status,
        this.createdAt,
        this.devices});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'] ?? "";
    email = json['email']?? "";;
    countryCode = json['country_code']?? "";;
    phoneNumber = json['phone_number']?? "";;
    profilePicture = json['profile_picture']?? "";;
    userName = json['user_name']?? "";;
    bio = json['bio']?? "";;
    contactSync = json['contact_sync']?? "";;
    profileLevel = json['profile_level']?? "";;
    notificationEnrolled = json['notification_enrolled']?? "";;
    status = json['status']?? "";;
    createdAt = json['createdAt']?? "";;
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(new Devices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['profile_picture'] = this.profilePicture;
    data['user_name'] = this.userName;
    data['bio'] = this.bio;
    data['contact_sync'] = this.contactSync;
    data['profile_level'] = this.profileLevel;
    data['notification_enrolled'] = this.notificationEnrolled;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.devices != null) {
      data['devices'] = this.devices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Devices {
  int? id;
  int? userId;
  String? platform;
  String? deviceId;
  String? createdAt;
  String? updatedAt;

  Devices(
      {this.id,
        this.userId,
        this.platform,
        this.deviceId,
        this.createdAt,
        this.updatedAt});

  Devices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    platform = json['platform'];
    deviceId = json['device_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['platform'] = this.platform;
    data['device_id'] = this.deviceId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}