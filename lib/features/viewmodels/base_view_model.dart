import 'package:flutter/material.dart';
import '../../product/service/cache_manager.dart';
import '../../product/state/view_state.dart';

//Kullanıcı state durumları için enum sınıfları eklendi.
enum UserControl { UserLogged, UserNotLogged, UserWaitLogged }

class BaseViewModel extends ChangeNotifier {
  UserControl _userControl = UserControl.UserNotLogged;

  UserControl get userControl => _userControl;

  set userControl(UserControl userControl) {
    _userControl = userControl;
  }

  bool disposed = false;

  ViewState _state = ViewState.Idle;

  BaseViewModel() {
    _userCheckAuth();
  }

  //Kullanıcının Auth durumunu kontrol eden method.
  Future<void> _userCheckAuth() async {
    userControl = UserControl.UserWaitLogged;
    bool? token = await CacheManager.instance.getCacheBoolItem(key: 'token');
    if (token != null && token == true) {
      userControl = UserControl.UserLogged;
    } else {
      userControl = UserControl.UserNotLogged;
    }
    notifyListeners();
  }

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  //BaseViewModel tarafından türeyen parent alan viewlerin dispose durumu için method.
  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
}
