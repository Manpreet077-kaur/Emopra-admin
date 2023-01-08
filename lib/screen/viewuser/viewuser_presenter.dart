

import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/model/user_details_response.dart';
import 'package:flutter_emporasports/model/user_list_response.dart';
import 'package:flutter_emporasports/untils/rest_ds.dart';

abstract class ViewUserInterface {
  onViewUserSuccess(UserListResponse user);
  onBlockUserSuccess(SuccessResponse user);
  onError(int errorCode);
}

class ViewUserPresenter {
  ViewUserInterface _view;
  RestDatasource api = new RestDatasource();

  ViewUserPresenter(this._view);

  doUserListAPI(String search,int skip,int limit) {
    api.getUserListData(search,skip,limit)
        .then((UserListResponse user) {
      if (user.statusCode! == 200) {
        _view.onViewUserSuccess(user);
      }else if(user.statusCode! == 400)
        {
          _view.onError(user.statusCode!);
        }
      else {
        _view.onError(user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(400));
  }
//End

  doUserBlockAPI(String user_id,String status) {
    api.postBlockUser(user_id, status)
        .then((SuccessResponse user) {
      if (user.statusCode! == 200) {
        _view.onBlockUserSuccess(user);
      }else if(user.statusCode! == 400)
      {
        _view.onError(user.statusCode!);
      }
      else {
        _view.onError(user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(400));
  }


//End
}
