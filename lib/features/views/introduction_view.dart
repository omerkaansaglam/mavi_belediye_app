import 'package:flutter/material.dart';
import '../viewmodels/login_view_model.dart';
import 'package:provider/src/provider.dart';
import '../../core/components/widget/custom_elevated_button.dart';
import '../../core/constants/image/image_constant.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/extensions/language_extension.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../core/init/navigation/navigation_service.dart';
import '../../product/widgets/container/custom_opacity_image_container.dart';
import '../../product/widgets/text/locale_text.dart';

//Açılış Sayfası
class IntroductionView extends StatelessWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: _buildContainer(context),
    );
  }

  CustomOpacityImageContainer _buildContainer(BuildContext context) {
    return CustomOpacityImageContainer(
      assetName: ImageConstants.instance.loginBackground,
      child: Padding(
        padding: context.paddingLow,
        child: _buildColumn(context),
      ),
    );
  }

  Column _buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [const SizedBox(), _buildTitleText(context), _buildColumnButtons(context)],
    );
  }

  Column _buildColumnButtons(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          style: context.textTheme.button?.copyWith(color: Colors.white),
          primaryColor: context.theme.primaryColor,
          title: LocaleKeys.introduction_login_button.locale,
          onPressed: () async {
            await NavigationService.instance.navigateToPage(path: '/login');
          },
        ),
        CustomElevatedButton(
          style: context.textTheme.button,
          title: LocaleKeys.introduction_guest_button.locale,
          onPressed: () async {
            context.read<LoginViewModel>().guestLogin();
          },
        )
      ],
    );
  }

  LocaleText _buildTitleText(BuildContext context) {
    return LocaleText(
      text: LocaleKeys.introduction_title,
      style: context.textTheme.headline1,
    );
  }
}
