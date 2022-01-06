import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/widget/custom_elevated_button.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/extensions/language_extension.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../product/widgets/input/normal_form_input.dart';
import '../../product/widgets/input/password_input_field.dart';
import '../../product/widgets/text/locale_text.dart';
import '../viewmodels/login_view_model.dart';

//Login Sayfası
class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKeyLogin = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: Form(key: formKeyLogin, child: _buildColumn(context)),
    );
  }

  Column _buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTitleText(context),
        _buildUserNameField(context),
        _buildUserPasswordField(context),
        Consumer<LoginViewModel>(
          builder: (context, userModel, child) {
            return _buildUserNotFound(userModel, context);
          },
        ),
        _buildLoginButton(context)
      ],
    );
  }

  Visibility _buildUserNotFound(LoginViewModel userModel, BuildContext context) {
    return Visibility(
      visible: userModel.userNotFound,
      child: LocaleText(
        text: LocaleKeys.login_invalid_usernameAndPassword,
        style: context.textTheme.bodyText1?.copyWith(color: Colors.red),
      ),
    );
  }

  Padding _buildLoginButton(BuildContext context) {
    return Padding(
        padding: context.paddingMedium,
        child: CustomElevatedButton(
          style: context.textTheme.button?.copyWith(color: Colors.white),
          primaryColor: context.theme.primaryColor,
          title: LocaleKeys.login_login_button.locale,
          onPressed: () async {
            if (formKeyLogin.currentState!.validate()) {
              formKeyLogin.currentState?.save();
              await context.read<LoginViewModel>().loginUser(userNameController.text, passwordController.text);
            }
          },
        ));
  }

  Padding _buildUserPasswordField(BuildContext context) {
    return Padding(
      padding: context.paddingMedium,
      child: PasswordInputField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bu alan zorunludur.';
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        controller: passwordController,
      ),
    );
  }

  Padding _buildUserNameField(BuildContext context) {
    return Padding(
      padding: context.paddingMedium,
      child: NormalInputFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bu alan zorunludur';
            }
            return null;
          },
          onSaved: (value) {
            userNameController.text = value!;
          },
          controller: userNameController,
          title: LocaleKeys.login_userName.locale,
          data: context.theme),
    );
  }

  Padding _buildTitleText(BuildContext context) {
    return Padding(
      padding: context.paddingMedium,
      child: LocaleText(
        text: LocaleKeys.login_title,
        style: context.textTheme.headline2,
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: context.theme.primaryIconTheme,
    );
  }
}
