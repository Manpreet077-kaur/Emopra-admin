import 'package:flutter_emporasports/model/user_details_response.dart';
import 'package:flutter_emporasports/untils/rest_ds.dart';

abstract class ProfileInterface {
  onUserDetailsSuccess(UserDetailResponse user);
  onError(int errorCode);
}

class ProfilePresenter {
  ProfileInterface _view;
  RestDatasource api = new RestDatasource();

  ProfilePresenter(this._view);


  doUserDetailsAPI(String user_id) {
    api.getUserDetailsData(user_id)
        .then((UserDetailResponse user) {
      if (user.statusCode == 200) {
        _view.onUserDetailsSuccess(user);
      }else if(user.statusCode == 400)
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
