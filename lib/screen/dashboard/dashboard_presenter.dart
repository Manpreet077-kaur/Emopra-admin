import 'package:flutter_emporasports/model/dashboard_total_user_response.dart';
import 'package:flutter_emporasports/untils/rest_ds.dart';

abstract class DashboardInterface {
  onDashboardSuccess(DashboardUserResponse user);
  onError(int errorCode);
}

class DashboardPresenter {
  DashboardInterface _view;
  RestDatasource api = new RestDatasource();
  DashboardPresenter(this._view);
  doDashboardUserAPI() {
    api.getDashboardUser()
        .then((DashboardUserResponse user) {
      if (user.statusCode == 200) {
        _view.onDashboardSuccess(user);
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
