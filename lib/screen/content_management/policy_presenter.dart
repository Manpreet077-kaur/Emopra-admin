
import 'package:flutter_emporasports/model/login_response.dart';
import 'package:flutter_emporasports/model/success_response.dart';

import '../../untils/rest_ds.dart';

abstract class PolicyInterface {
  onSuccess(SuccessResponse user);
  onError(String msg,int errorCode);
}

class PolicyPresenter {
  PolicyInterface _view;
  RestDatasource api = new RestDatasource();

  PolicyPresenter(this._view);

  doPrivacyPolicy(String terms_and_conditions) {
  api.addTermconditions(terms_and_conditions)
      .then((SuccessResponse user) {
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

  doAddTermsConditions(String terms_and_conditions) {
    api.addTermconditions(terms_and_conditions)
        .then((SuccessResponse user) {
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

  doAddPrivatePolicy(String privacy_policy) {
    api.addPrivatePolicy(privacy_policy)
        .then((SuccessResponse user) {
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
}
