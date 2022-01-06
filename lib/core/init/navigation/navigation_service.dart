import 'package:flutter/cupertino.dart';

import 'INavigationService.dart';

//NavigationService erişimi için eager bir singleton oluşturuldu.
class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  //NagivatorState türünde Global bir key atandı.
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  //Clear page için (Route<dynamic> route) => false yapısı kısaltıldı.
  final removeAllOldRoutes = (Route<dynamic> route) => false;

  //INavigationService üzerinde oluşturulan implements olduktan sonra override edildi.
  //Daha sonrasında Navigate işlemi için method sağlandı.
  @override
  Future<void> navigateToPage({String? path, Object? data}) async {
    await navigatorKey.currentState?.pushNamed(path!, arguments: data);
  }

  //INavigationService üzerinde oluşturulan implements olduktan sonra override edildi.
  //Daha sonrasında Navigate Clear işlemi için method sağlandı.
  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(path!, removeAllOldRoutes, arguments: data);
  }
}
