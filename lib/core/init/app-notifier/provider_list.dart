import '../../../features/viewmodels/base_view_model.dart';

import '../../../features/viewmodels/facilities_view_model.dart';
import '../../../features/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';
//Provider ile dinlediğimiz servisler uygulama açılışında kullanılmak üzere dependItems üzerine alındı.
// Lazy singleton kullanıldı.

import 'package:provider/single_child_widget.dart';

import '../navigation/navigation_service.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;

  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider<BaseViewModel>(create: (context) => BaseViewModel()),
    ChangeNotifierProvider<LoginViewModel>(create: (context) => LoginViewModel()),
    Provider.value(value: NavigationService.instance)
  ];
}
