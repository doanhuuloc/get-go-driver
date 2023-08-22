import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/services/api/api_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PasswordScreen extends StatefulWidget {
  final String phone;
  const PasswordScreen({super.key, required this.phone});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  login(pin) async {
    final response = await ApiAuth.login(widget.phone, pin);
    if (response['statusCode' == 200]) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      print("cout<< Sai mật khẩu");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Nhập mật khẩu của bạn"),
              const SizedBox(height: 20),
              Center(
                child: Pinput(
                  // defaultPinTheme: PinTheme(
                  //   textStyle: TextStyle(fontSize: 20)
                  // ),

                  length: 6,
                  showCursor: true,
                  autofocus: true,
                  onCompleted: (pin) => login(pin),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
