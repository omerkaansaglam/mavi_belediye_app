import 'package:flutter/material.dart';
import '../../../features/views/announcements_view.dart';
import '../../../features/views/auth_control_view.dart';
import '../../../features/views/facilities_view.dart';
import '../../../features/views/hello_view.dart';
import '../../../features/views/introduction_view.dart';
import '../../../features/views/login_view.dart';
import '../../constants/navigation/navigation_constants.dart';

//Pagelerin Route durumu için eager bir singleton oluşturuldu.
class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  //Flutter-Dart'ın sağlamış olduğu RouteSetting yapısı ve constantlar kullanıldı.
  //Geçiş yapılacak sayfanın constantlara bağlı state durumu belirlendi.
  Route<dynamic> routeGenerate(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.AUTH_CONTROL:
        return _normalNavigate(const AuthControlView(), args);
      case NavigationConstants.INTRO:
        return _normalNavigate(const IntroductionView(), args);
      case NavigationConstants.LOGIN:
        return _normalNavigate(LoginView(), args);
      case NavigationConstants.HELLO:
        return _normalNavigate(HelloView(), args);
      case NavigationConstants.FACILITIES:
        return _normalNavigate(const FacilitiesView(), args);
      case NavigationConstants.ANNOUNCEMENTS:
        return _normalNavigate(const AnnouncementsView(), args);
      default:
        return _normalNavigate(Container(), args);
    }
  }

  //Flutter default navigate işlemi. Buraya isteğe bağlı animasyonlu geçiş gibi durumları eklenebilir.
  MaterialPageRoute _normalNavigate(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
