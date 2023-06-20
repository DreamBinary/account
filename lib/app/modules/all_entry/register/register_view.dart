import 'dart:io';

import 'package:account/app/component/mytopbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/mytextfield.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_string.dart';
import '../../../theme/app_text_theme.dart';
import '../login/login_logic.dart';
import 'register_logic.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final logic = Get.find<RegisterLogic>();
  final state = Get.find<RegisterLogic>().state;
  final logicLogin = Get.find<LoginLogic>();
  final stateLogin = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        middle: Text(
          AppString.register,
          style: AppTS.normal,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Column(children: [
          // const HeaderComponent(showAdd: true),
          SizedBox(height: 30.h),
          ...getWidgets(),
          SizedBox(height: 30.h),
          MaterialButton(
            shape: const StadiumBorder(),
            minWidth: 300,
            height: 40,
            color: AppColors.color_list[5],
            onPressed: () {
              logic.register();
            },
            child: Text(
              AppString.register,
              style: AppTS.normal.copyWith(
                color: AppColors.textColor(AppColors.color_list[5]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> getWidgets() {
    return Platform.isIOS
        ? [
            UsernameTextFieldIOS(stateLogin.usernameCtrl),
            SizedBox(height: 10.h),
            VerifyTextFieldIOS(state.verifyCtrl,
                onSend: () => {logicLogin.sendSms()},
                onSubmitted: (_) => logicLogin.sendSms()),
            SizedBox(height: 10.h),
            PasswordTextFieldIOS(
              stateLogin.passwordCtrl,
              // label: S.password,
              hint: AppString.passwordInput,
              prefixIcon: Icons.privacy_tip_outlined,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10.h),
            PasswordTextFieldIOS(state.verifyPasswordCtrl,
                // label: S.verifyPassword,
                hint: AppString.verifyPasswordInput,
                prefixIcon: Icons.password,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => {
                      // logic.register(), KeyboardUtils.hideKeyboard(context),
                    })
          ]
        : [
            UsernameTextField(stateLogin.usernameCtrl,
                onClear: () => stateLogin.usernameCtrl.clear()),
            VerifyTextField(state.verifyCtrl,
                onSend: () => {logicLogin.sendSms()},
                onSubmitted: (_) => logicLogin.sendSms()),
            PasswordTextField(
              stateLogin.passwordCtrl,
              // label: S.password,
              hint: AppString.passwordInput,
              prefixIcon: Icons.privacy_tip_outlined,
              onClear: () => stateLogin.passwordCtrl.clear(),
              textInputAction: TextInputAction.next,
            ),
            PasswordTextField(state.verifyPasswordCtrl,
                hint: AppString.verifyPasswordInput,
                prefixIcon: Icons.password,
                onClear: () => state.verifyPasswordCtrl.clear(),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => {
                      // logic.register(), KeyboardUtils.hideKeyboard(context),
                    })
          ];
  }

  @override
  void dispose() {
    Get.delete<RegisterLogic>();
    super.dispose();
  }
}
