import 'package:flutter/material.dart';
import '../viewmodels/base_view_model.dart';
import 'hello_view.dart';
import 'introduction_view.dart';
import 'package:provider/provider.dart';

//Kullanıcının auth durumuna göre gösterilecek başlangıç sayfaları switch case ile belirlendi.
class AuthControlView extends StatefulWidget {
  const AuthControlView({Key? key}) : super(key: key);

  @override
  _AuthControlViewState createState() => _AuthControlViewState();
}

class _AuthControlViewState extends State<AuthControlView> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<BaseViewModel>(context);
    switch (authService.userControl) {
      case UserControl.UserLogged:
        return HelloView();
      case UserControl.UserNotLogged:
        return const IntroductionView();
      case UserControl.UserWaitLogged:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
