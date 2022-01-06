import 'package:flutter/material.dart';
import '../../core/constants/navigation/navigation_constants.dart';
import '../viewmodels/base_view_model.dart';
import '../viewmodels/login_view_model.dart';
import 'package:provider/src/provider.dart';
import '../../core/constants/image/image_constant.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../core/init/navigation/navigation_service.dart';
import '../../product/widgets/card/custom_card.dart';
import '../../product/widgets/container/custom_cover_image_container.dart';
import '../../product/widgets/icon/exit_icon.dart';
import '../../product/widgets/text/locale_text.dart';

//Hoşgeldiniz Sayfası
class HelloView extends StatelessWidget {
  HelloView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomCoverImageContainer(assetName: ImageConstants.instance.loginBackground),
          Padding(
            padding: context.paddingHighVertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                  onTap: () {
                    NavigationService.instance.navigateToPage(path: NavigationConstants.FACILITIES);
                  },
                  subTitle: LocaleKeys.hello_facilities,
                  widget: LocaleText(
                    text: LocaleKeys.hello_facilities_first,
                    style: context.textTheme.headline3,
                  ),
                ),
                CustomCard(
                  onTap: () {
                    NavigationService.instance.navigateToPage(path: NavigationConstants.ANNOUNCEMENTS);
                  },
                  subTitle: LocaleKeys.hello_announcements,
                  widget: LocaleText(
                    text: LocaleKeys.hello_announcements_first,
                    style: context.textTheme.headline3,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              context.read<LoginViewModel>().logoutUser();
              context.read<BaseViewModel>().userControl = UserControl.UserNotLogged;
              NavigationService.instance.navigateToPageClear(path: '/');
            },
            icon: const ExitIcon())
      ],
      title: LocaleText(
        text: LocaleKeys.hello_title,
        style: context.textTheme.headline1?.copyWith(color: Colors.white),
      ),
    );
  }
}
