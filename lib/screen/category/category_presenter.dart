import 'package:flutter_emporasports/model/success_response.dart';
import '../../model/category_list_response.dart';
import '../../untils/rest_ds.dart';
import 'dart:io';

abstract class CategoryInterface {
  onAddCategorySuccess(SuccessResponse user);
  onCategoryListSuccess(CategoryListResponse categoryuser);
  onError(String msg,int errorCode);
  onCategoryListError(int msg);
  onDeleteRequestSuccess(SuccessResponse successResponse);
}

class CategoryPresenter {
  CategoryInterface _view;
  RestDatasource api = new RestDatasource();

  CategoryPresenter(this._view);

  doAddCategory(String category_name, List<int> category_image) {
    api.addCategory(category_name, category_image)
        .then((SuccessResponse user) {
      if (user.statusCode == 200) {
        _view.onAddCategorySuccess(user);
      } else if (user.statusCode == 400) {
        _view.onError(user.message!, user.statusCode!);
      }
      else {
        _view.onError(user.message!, user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 400));
  }

  doCategoryListAPI() {
    api.getCategoryListData()
        .then((CategoryListResponse user) {
      if (user.statusCode! == 200) {
        _view.onCategoryListSuccess(user);
      } else if (user.statusCode! == 400) {
        _view.onCategoryListError(user.statusCode!,);
      }
      else {
        _view.onCategoryListError(user.statusCode!);
      }
    }).catchError((Object error) => _view.onCategoryListError(400));
  }

  deleteAPI(String category_id) {
    api.ResquestDeletePost(category_id)
        .then((SuccessResponse user) {
      if (user.statusCode == 200) {
        _view.onDeleteRequestSuccess(user);
      }else if(user.statusCode == 400)
      {
        _view.onError(user.message!, user.statusCode!);
      }
      else {
        _view.onError(user.message!, user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 400));
  }



 doEditCategory(String category_id,String category_name, List<int> category_image,String status) {
    api.editCategory(category_id,category_name, category_image,status)
        .then((SuccessResponse user) {
      if (user.statusCode == 200) {
        _view.onAddCategorySuccess(user);
      } else if (user.statusCode == 400) {
        _view.onError(user.message!, user.statusCode!);
      }
      else {
        _view.onError(user.message!, user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(error.toString(), 400));
  }
  }

