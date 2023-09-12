import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/entity/user.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  final List<User> users = [
    User("admin", "0610"),
    User("demo", "demo"),
    User("user1", "0811"),
    User("user2", "0812"),
    User("user3", "0813"),
  ];

  void _login() {
    bool loginSuccessful = false;

    for (User user in users) {
      if (user.id == idController.text && user.password == pwController.text) {
        loginSuccessful = true;
        break;
      }
    }
    if (loginSuccessful) {
      Get.offAllNamed('/reservation_page');
    } else {
      Get.snackbar('로그인에 실패했습니다.', '아이디, 비밀번호를 다시 확인해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 250,  // 너비 조정
                    child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: 'ID',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: 250,  // 너비 조정
                    child: TextField(
                      controller: pwController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
