
import 'package:flutter_emporasports/model/login_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';

import '../../untils/rest_ds.dart';

abstract class ApiLoginInterface {
  onSuccess(LoginResponse user);
  onError(String msg,int errorCode);
  onForgotSuccess(SuccessResponse user);
}

class LoginPresenter {
  ApiLoginInterface _view;
  RestDatasource api = new RestDatasource();

  LoginPresenter(this._view);

  doLogin(String emailId, String password) {
    api.login(emailId, password)
        .then((LoginResponse user) {
      if (user.statusCode == 200) {
        _view.onSuccess(user);
      }else if(user.statusCode == 400)
        {
          _view.onError(user.message!,user.statusCode!);
        }
      else {
        _view.onError(user.message!,user.statusCode!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),400));
  }

  doForgotPassword(String emailId) {
    api.forgotPassword(emailId)
        .then((SuccessResponse user) {
      if (user.statusCode == 200) {
        _view.onForgotSuccess(user);
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
