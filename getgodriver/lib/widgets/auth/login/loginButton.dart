import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key,required this.login});
  final VoidCallback login;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: login,
      child: Container(
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).primaryColor),
          child: const Text(
            "ĐÂNG NHẬP",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
