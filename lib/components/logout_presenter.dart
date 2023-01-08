import 'package:flutter_emporasports/model/login_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';
import '../../untils/rest_ds.dart';

abstract class ApiLogoutInterface {
  onLogoutSuccess(SuccessResponse logoutUser);
  onError(String msg,int errorCode);
}

class LogoutPresenter {
  ApiLogoutInterface _view;
  RestDatasource api = new RestDatasource();
  LogoutPresenter(this._view);

  doLogout() {
    api.logOut()
        .then((SuccessResponse user) {
      if (user.statusCode == 200) {
        _view.onLogoutSuccess(user);
      }else if(user.statusCode == 400)
      {
        _view.onError(user.message!,user.statusCode!);
      }
      else {
        _view.onError(user.message!,user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),400));
  }
}
