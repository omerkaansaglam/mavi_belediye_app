import '../../product/service/cache_manager.dart';

import '../../core/init/navigation/navigation_service.dart';
import '../models/login_model.dart';
import 'base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  String? _userName;
  bool _isGuest = false;

  bool get isGuest => _isGuest;

  set isGuest(bool isGuest) {
    _isGuest = isGuest;
  }

  String? get userName => _userName;

  set userName(String? userName) {
    _userName = userName;
  }

  bool _userNotFound = false;

  bool get userNotFound => _userNotFound;

  set userNotFound(bool userNotFound) {
    _userNotFound = userNotFound;
  }

  //Kullanıcı giriş methodu - Burada api olmadığı için Mock data tarafından kontrol edildi.
  Future<void> loginUser(String name, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    userNotFound = true;
    if (name == LoginModel.mockUser.userName && password == LoginModel.mockUser.password) {
      userName = LoginModel.mockUser.userName;
      userNotFound = false;
      isGuest = false;
      await CacheManager.instance.addCacheBoolItem(key: 'token', value: true);
      var test = await CacheManager.instance.getCacheBoolItem(key: 'token');
      await NavigationService.instance.navigateToPageClear(path: '/hello');
    } else {
      userNotFound = true;
    }
    notifyListeners();
  }

  //Misafir girişini kontrol eden method
  Future<void> guestLogin() async {
    isGuest = true;
    await NavigationService.instance.navigateToPageClear(path: '/hello');
    notifyListeners();
  }

  //Auth olan kullanıcının çıkış durumu için yazılan method
  Future<bool> logoutUser() async {
    isGuest = false;
    userName = null;
    await CacheManager.instance.addCacheBoolItem(key: 'token', value: false);
    notifyListeners();
    return true;
  }
}
