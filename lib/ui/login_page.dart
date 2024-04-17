import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/utils/toast_utils.dart';
import 'package:storetools/widget/text_input_widget.dart';

import '../const/routes.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends BaseState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInputWidget(controller: _usernameController, label: '用户名'),
            TextInputWidget(controller: _passwordController, label: '密码', obscureText: true),
            TextButton(
                onPressed: _login,
                child: const Text("登录")
            )
          ],
        ),
      ),
    );
  }

  _login() async {
    var username = _usernameController.text.trim();
    var password = _passwordController.text.trim();
    print("username:$username password:$password");
    if (username.isEmpty || password.isEmpty) {
      showToast('用户名或者密码输入有误');
      return;
    }
    try {
      var user = await LCUser.login(username, password);
      await Navigator.pushNamed(context, Routes.home);
      Navigator.pop(context);
      showToast('登录成功');
    } on LCException catch (e) {
      log('登录失败 ${e.message}');
      showToast('登录失败: ${e.message}');
    }
  }
}