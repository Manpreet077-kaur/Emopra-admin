

import 'package:flutter_emporasports/model/success_response.dart';
import 'package:flutter_emporasports/model/user_details_response.dart';
import 'package:flutter_emporasports/model/user_list_response.dart';
import 'package:flutter_emporasports/untils/rest_ds.dart';

abstract class InActiveUserInterface {
  onViewUserSuccess(UserListResponse user);
  onBlockUserSuccess(SuccessResponse user);
  onError(int errorCode);
}

class InActiveUserPresenter {
  InActiveUserInterface _view;
  RestDatasource api = new RestDatasource();

  InActiveUserPresenter(this._view);

  doInActiveListAPI(int skip,int limit) {
    api.getInActiveData(skip,limit)
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
