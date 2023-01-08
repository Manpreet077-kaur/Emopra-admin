class UserDetailResponse {
  int? statusCode;
  UserDetails? data;

  UserDetailResponse({this.statusCode, this.data});

  UserDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new UserDetails.fromJson(json['data']) : null;
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

class UserDetails {
  int? id;
  String? firstName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? profilePicture;
  String? userName;
  String? bio;
  bool? contactSync;
  String? googleId;
  String? contactNumber;
  int? profileLevel;
  String? stripeCustomerId;
  bool? notificationEnrolled;
  bool? status;
  List<Items>? items;

  UserDetails(
      {this.id,
        this.firstName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.profilePicture,
        this.userName,
        this.bio,
        this.contactSync,
        this.googleId,
        this.contactNumber,
        this.profileLevel,
        this.stripeCustomerId,
        this.notificationEnrolled,
        this.status,
        this.items});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    firstName = json['first_name']??"";
    email = json['email']??"";
    countryCode = json['country_code']??"";
    phoneNumber = json['phone_number']??"";
    profilePicture = json['profile_picture']??"";
    userName = json['user_name']??"";
    bio = json['bio']??"";
    contactSync = json['contact_sync']??"";
    googleId = json['google_id']??"";
    contactNumber = json['contact_number']??"";
    profileLevel = json['profile_level']??"";
    stripeCustomerId = json['stripe_customer_id']??"";
    notificationEnrolled = json['notification_enrolled']??"";
    status = json['status']??"";
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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
    data['google_id'] = this.googleId;
    data['contact_number'] = this.contactNumber;
    data['profile_level'] = this.profileLevel;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['notification_enrolled'] = this.notificationEnrolled;
    data['status'] = this.status;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? userId;
  String? title;
  String? description;
  int? categoryId;
  Null? subCategoryId;
  String? itemType;
  List<String>? tags;
  String? sellType;
  int? price;
  int? itemQuantity;
  String? bidEndDate;
  String? itemImageThumbnail;
  String? bidStatus;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.categoryId,
        this.subCategoryId,
        this.itemType,
        this.tags,
        this.sellType,
        this.price,
        this.itemQuantity,
        this.bidEndDate,
        this.itemImageThumbnail,
        this.bidStatus,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    itemType = json['item_type'];
    tags = json['tags'].cast<String>();
    sellType = json['sell_type'];
    price = json['price'];
    itemQuantity = json['item_quantity'];
    bidEndDate = json['bid_end_date'];
    itemImageThumbnail = json['item_image_thumbnail'];
    bidStatus = json['bid_status'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['item_type'] = this.itemType;
    data['tags'] = this.tags;
    data['sell_type'] = this.sellType;
    data['price'] = this.price;
    data['item_quantity'] = this.itemQuantity;
    data['bid_end_date'] = this.bidEndDate;
    data['item_image_thumbnail'] = this.itemImageThumbnail;
    data['bid_status'] = this.bidStatus;
    data['deletedAt'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}