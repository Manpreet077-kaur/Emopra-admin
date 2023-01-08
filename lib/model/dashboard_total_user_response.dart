class DashboardUserResponse {
  int? statusCode;
  Data? data;

  DashboardUserResponse({this.statusCode, this.data});

  DashboardUserResponse.fromJson(Map<String, dynamic> json) {
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
  int? totalUsers;
  int? activeusers;
  int? inactiveusers;
  double? totalEarning;

  Data(
      {this.totalUsers,
        this.activeusers,
        this.inactiveusers,
        this.totalEarning});

  Data.fromJson(Map<String, dynamic> json) {
    totalUsers = json['totalUsers'];
    activeusers = json['activeusers'];
    inactiveusers = json['inactiveusers'];
    totalEarning = json['totalEarning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalUsers'] = this.totalUsers;
    data['activeusers'] = this.activeusers;
    data['inactiveusers'] = this.inactiveusers;
    data['totalEarning'] = this.totalEarning;
    return data;
  }
}
