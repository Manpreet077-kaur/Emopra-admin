import 'package:flutter/material.dart';
import 'package:flutter_emporasports/inActive/inactive_user_screen.dart';
import 'package:flutter_emporasports/route/route_name.dart';
import 'package:flutter_emporasports/screen/category/category_list_screen.dart';
import 'package:flutter_emporasports/screen/category/addcategory_screen.dart';
import 'package:flutter_emporasports/screen/changepassword/changepwd_screen.dart';
import 'package:flutter_emporasports/screen/content_management/content_management_screen.dart';
import 'package:flutter_emporasports/screen/content_management/privacy_policy_screen.dart';
import 'package:flutter_emporasports/screen/content_management/terms_and_condition_screen.dart';
import 'package:flutter_emporasports/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_emporasports/screen/login/login_screen.dart';
import 'package:flutter_emporasports/screen/profile/profile_screen.dart';
import 'package:flutter_emporasports/screen/viewuser/view_user_screen.dart';

import 'untils/sharedpref/shared_prefrence.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State{
  @override
  initState() {
    SessionManager.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(
          // makes all platforms that can run Flutter apps display routes without any animation
          builders: Map<TargetPlatform,
              _InanimatePageTransitionsBuilder>.fromIterable(
              TargetPlatform.values.toList(),
              key: (dynamic k) => k,
              value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
        ),
      ),
      initialRoute: RouteNames.login,
      navigatorObservers: [RouteObserver()],
      routes: {
        RouteNames.login: (_) =>  LoginScreen(),
        RouteNames.dashboard: (_) =>  DashboardScreen(),
        RouteNames.addcategory: (_) =>  AddCategoryScreen(categoryName: "",categoryId: "",imageUrl: "",),
        RouteNames.viewuser: (_) =>  ViewUserScreen(),
        RouteNames.inActiveUser: (_) => InActiveScreen(),
        RouteNames.profile: (_) =>  ProfileScreen(id:""),
        RouteNames.contentManagement: (_) =>  ContentManagement(),
        RouteNames.changePasswordScreen: (_) =>  ChangePasswordScreen(),
        RouteNames.categoryList: (_) =>  CategoryListScreen(),
        RouteNames.privacyPolicyScreen: (_) =>  PrivacyPolicyScreen(),
        RouteNames.termsConditionScreen: (_) =>  TermsConditionScreen(),
        RouteNames.addcategory: (_) =>  AddCategoryScreen(categoryName: "",categoryId: "",imageUrl: "",),
      },
      home:LoginScreen(),
    );
  }
}
/// This class is used to build page transitions that don't have any animation
class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}