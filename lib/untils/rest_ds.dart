import 'dart:async';
import 'dart:io';
import 'package:flutter_emporasports/model/dashboard_total_user_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/model/user_details_response.dart';
import 'package:flutter_emporasports/model/user_list_response.dart';
import 'package:flutter_emporasports/untils/sharedpref/preferences.dart';
import 'package:flutter_emporasports/untils/sharedpref/shared_prefrence.dart';
import '../model/category_list_response.dart';
import '../model/login_response.dart';
import 'network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://18.119.23.86:3000/";

  static final LOGIN = BASE_URL + "admin/login";
  static final USER_LIST_API = BASE_URL + "admin/userList";
  static final INACTIVE_USER_LIST_API = BASE_URL + "admin/inactive-user-list";
  static final USER_DETAIL_API = BASE_URL + "admin/userDetails?user_id=";
  static final BLOCK_UNBLOCK_API = BASE_URL + "admin/block-unblock";
  static final CHANAGE_PASSWORD_API = BASE_URL + "admin/change-password";
  static final ADD_CATEGORY_API = BASE_URL + "category/add";
  static final CATEGORY_List_API = BASE_URL + "category/list";
  static final CATEGORY_DELETE = BASE_URL + "category/delete";
  static final EDIT_CATEGORY = BASE_URL + "category/edit";
  static final DASHBOARD_USER = BASE_URL + "admin/countData";
  static final FORGOT_PASSWORD = BASE_URL + "admin/forgotPassword";
  static final ADD_TERM_CONDITION = BASE_URL + "admin/terms-and-conditions";
  static final ADD_POLICY_CONDITION = BASE_URL + "admin/privacy-policy";
  static final LOGOUT = BASE_URL + "admin/logout";

  Future<LoginResponse> login(String emailId, String password) {
    return _netUtil.postApi(LOGIN, body: {
      "email": emailId,
      "password": password,
    }).then((dynamic res) {
      print("login Data  " + res.toString());
      return LoginResponse.fromJson(res);
    });
  }

  Future<UserListResponse> getUserListData(String search,int skip,int limit) {
    return _netUtil.get(
      USER_LIST_API+"?search="+ search.toString()+"&skip="+skip.toString()+"&limit="+limit.toString(),
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN)
      },
    ).then((dynamic res) {
      return UserListResponse.fromJson(res);
    });
  }

  Future<UserListResponse> getInActiveData(int skip,int limit) {
    return _netUtil.get(
      INACTIVE_USER_LIST_API+"?skip="+ skip.toString()+"&limit="+limit.toString(),
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN)
      },
    ).then((dynamic res) {
      return UserListResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> postBlockUser(String user_id, String status) {
    return _netUtil.postApiWithHeader(BLOCK_UNBLOCK_API, body: {
      "user_id": user_id,
      "status": status,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> changepassword(String old_password,
      String new_password) {
    return _netUtil.postApiWithHeader(CHANAGE_PASSWORD_API, body: {
      "old_password": old_password,
      "new_password": new_password,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<UserDetailResponse> getUserDetailsData(String user_id) {
    return _netUtil.get(
      USER_DETAIL_API + user_id,
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN),
      },
    ).then((dynamic res) {
      return UserDetailResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> addCategory(String category_name,
      List<int> category_image) async {
    return _netUtil.multipartApi(ADD_CATEGORY_API,
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN),
      },
      category_name,
      category_image,
    )
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<CategoryListResponse> getCategoryListData() {
    return _netUtil.get(
      CATEGORY_List_API,
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN)
      },
    ).then((dynamic res) {
      return CategoryListResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> ResquestDeletePost(String category_id) {
    return _netUtil.postApiWithHeader(CATEGORY_DELETE, body: {
      "category_id": category_id,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }


  Future<SuccessResponse> editCategory(String category_id,String category_name,
      List<int> category_image,String status) {
    return _netUtil.editMultipartApi(EDIT_CATEGORY,
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN),
      },
      category_id,
      category_name,
      category_image,
      status,
    )
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<DashboardUserResponse> getDashboardUser() {
    return _netUtil.get(
      DASHBOARD_USER,
      {
        "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN)
      },
    ).then((dynamic res) {
      return DashboardUserResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> logOut() {
    return _netUtil.postApiWithHeader(LOGOUT).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> forgotPassword(String email) {
    return _netUtil.postApiWithHeader(FORGOT_PASSWORD,body:{
      "email": email,
    }).then((dynamic res) {
      print("forgot Data  " + res.toString());
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> addTermconditions(String terms_and_conditions) {
    return _netUtil.postApiWithHeader(ADD_TERM_CONDITION, body: {
      "terms_and_conditions": terms_and_conditions,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<SuccessResponse> addPrivatePolicy(String privacy_policy) {
    return _netUtil.postApiWithHeader(ADD_POLICY_CONDITION, body: {
      "privacy_policy": privacy_policy,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
}