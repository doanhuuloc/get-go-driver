import 'package:flutter/material.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/api/api_auth.dart';
import 'package:getgodriver/widgets/auth/login/inputPhone.dart';
import 'package:getgodriver/widgets/auth/login/loginButton.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();
  PhoneNumber phone = new PhoneNumber();
  bool validPhone = false;

  updatePhone(PhoneNumber newphone) {
    setState(() {
      phone = newphone;
    });
  }

  updateValidPhone(bool value) {
    setState(() {
      validPhone = value;
    });
  }

  login() async {
    if (validPhone) {
      final response = await ApiAuth.checkPhone(phone.phoneNumber!);
      if (response['statusCode'] == 200) {
        Navigator.pushNamed(context, Routes.password,
            arguments: phone.phoneNumber);
      } else {
        _notifyErrorMessage("Không tìm thấy tài khoản");
      }
    } else {
      _notifyErrorMessage("Số điện thoại chưa đúng định dạng");
    }
  }

  signup() {}

  _notifyErrorMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Thông báo"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Thoát"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(
                  image: AssetImage("assets/imgs/title.png"),
                ),
                Column(children: [
                  InputPhone(
                    controller: controller,
                    phone: phone,
                    validPhone: validPhone,
                    updatePhone: updatePhone,
                    updateValidPhone: updateValidPhone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LoginButton(login: login),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: signup,
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          "ĐĂNG KÝ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        )),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
